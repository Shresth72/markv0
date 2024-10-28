package main

import (
	"encoding/csv"
	"flag"
	"fmt"
	"net"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/cilium/ebpf"
	"github.com/cilium/ebpf/link"
)

const (
	TYPE_ENTER = 1
	TYPE_DROP  = 2
	TYPE_PASS  = 3
	QUEUE_AVG  = 0

	ETH_ALEN = 6
)

type datarec struct {
	RxPackets uint64
	RxBytes   uint64
}

type telrec struct {
	Timestamp      uint64
	ProcessingTime uint64
	LastRxPackets  uint64 // New field for last recorded packets
	LastTimestamp  uint64 // New field for last timestamp
}

func parseMAC(macStr string) [ETH_ALEN]byte {
	var mac [ETH_ALEN]byte
	for i := 0; i < ETH_ALEN; i++ {
		fmt.Sscanf(macStr[i*3:i*3+2], "%2hhx", &mac[i])
	}
	return mac
}

func main() {
	interfaceName := flag.String("interface", "", "Network interface to attach XDP program")
	srcMACStr := flag.String("src-mac", "", "Source MAC address to populate redirect_params")
	destMACStr := flag.String("dest-mac", "", "Destination MAC address to populate redirect_params")
	txPortIndex := flag.Int("tx-port", -1, "Index of the port for tx_port map")
	queueAvg := flag.Uint64("q", 0, "Average queue length to populate queue_avg_map")
	flag.Parse()

	if *interfaceName == "" {
		fmt.Println(
			"No interface specified. Use the -interface flag to specify the network interface.",
		)
		os.Exit(1)
	}

	ifaceIdx, err := net.InterfaceByName(*interfaceName)
	if err != nil {
		panic(fmt.Sprintf("Failed to get interface %s: %v\n", *interfaceName, err))
	}

	spec, err := ebpf.LoadCollectionSpec("./c/kern.o")
	if err != nil {
		panic(err)
	}

	coll, err := ebpf.NewCollection(spec)
	if err != nil {
		panic(fmt.Sprintf("Failed to create new collection: %v\n", err))
	}
	defer coll.Close()

	prog := coll.Programs["xdp_redirect_map_func"]
	if prog == nil {
		panic("No program named 'xdp_redirect_map_func' found in collection")
	}

	opts := link.XDPOptions{
		Program:   prog,
		Interface: ifaceIdx.Index,
	}
	lnk, err := link.AttachXDP(opts)
	if err != nil {
		panic(err)
	}
	defer lnk.Close()

	redirectParamsMap, ok := coll.Maps["redirect_params"]
	if !ok {
		panic("No map named 'redirect_params' found in collection")
	}

	txPortMap, ok := coll.Maps["tx_port"]
	if !ok {
		panic("No map named 'tx_port' found in collection")
	}

	xdpStatsMap, ok := coll.Maps["xdp_stats_map"]
	if !ok {
		panic("No map named 'xdp_stats_map' found in collection")
	}

	telemetryStatsMap, ok := coll.Maps["telemetry_stats_map"]
	if !ok {
		panic("No map named 'telemetry_stats_map' found in collection")
	}

	srcMAC := parseMAC(*srcMACStr)
	destMAC := parseMAC(*destMACStr)
	srcMACKey := [ETH_ALEN]byte{}
	copy(srcMACKey[:], srcMAC[:])
	if err := redirectParamsMap.Update(&srcMACKey, &destMAC, ebpf.UpdateAny); err != nil {
		panic(fmt.Sprintf("Failed to update redirect_params map: %v", err))
	}

	if *txPortIndex != -1 {
		if err := txPortMap.Update(uint32(0), uint32(*txPortIndex), ebpf.UpdateAny); err != nil {
			panic(fmt.Sprintf("Failed to update tx_port map: %v", err))
		}
	}

	dataRec := datarec{RxPackets: 0, RxBytes: 0}
	for i := 0; i < 5; i++ {
		if err := xdpStatsMap.Update(uint32(i), &dataRec, ebpf.UpdateAny); err != nil {
			panic(fmt.Sprintf("Failed to initialize xdp_stats_map: %v", err))
		}
	}

	telRec := telrec{Timestamp: 0, ProcessingTime: 0, LastRxPackets: 0, LastTimestamp: 0}
	for i := 0; i < 5; i++ {
		if err := telemetryStatsMap.Update(uint32(i), &telRec, ebpf.UpdateAny); err != nil {
			panic(fmt.Sprintf("Failed to initialize telemetry_stats_map: %v", err))
		}
	}

	queueAvgMap, ok := coll.Maps["queue_avg_map"]
	if !ok {
		panic("No map named 'queue_avg_map' found in collection")
	}

	if err := queueAvgMap.Update(uint32(0), queueAvg, ebpf.UpdateAny); err != nil {
		panic(fmt.Sprintf("Failed to update queue_avg_map: %v", err))
	}

	fmt.Println("Successfully loaded and attached BPF program and populated maps")

	go collectStats2(xdpStatsMap, telemetryStatsMap)

	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c
}

func collectStats(xdpStatsMap *ebpf.Map, telemetryStatsMap *ebpf.Map) {
	startTime := time.Now()
	var lastRxPackets int64
	lastTimestamp := startTime

	// Create or open the CSV file
	file, err := os.Create("stats.csv")
	if err != nil {
		fmt.Printf("Failed to create CSV file: %v\n", err)
		return
	}
	defer file.Close()

	writer := csv.NewWriter(file)
	defer writer.Flush()

	// Write header
	if err := writer.Write([]string{"Time", "Dropped", "Passed", "ProcessingTime", "RPS"}); err != nil {
		fmt.Printf("Failed to write header to CSV: %v\n", err)
		return
	}

	for {
		var dropped, passed int64
		totalRxPackets := int64(0)

		// Fetch packet statistics
		for i := 0; i < 5; i++ {
			var stats datarec
			if err := xdpStatsMap.Lookup(uint32(i), &stats); err != nil {
				fmt.Printf("Failed to get stats for key %d: %v\n", i, err)
				continue
			}
			totalRxPackets += int64(stats.RxPackets)

			if i == TYPE_DROP {
				dropped += int64(stats.RxPackets)
			} else if i == TYPE_PASS {
				passed += int64(stats.RxPackets)
			}
		}

		// Calculate RPS (Requests per Second)
		currentTime := time.Now()
		elapsedTime := currentTime.Sub(lastTimestamp).Seconds()
		rps := float64(totalRxPackets-lastRxPackets) / elapsedTime

		// Update last observed values
		lastRxPackets = totalRxPackets
		lastTimestamp = currentTime

		// Fetch processing time from telemetryStatsMap
		processingTime := int64(0) // Default if no processing times are available
		for i := 0; i < 5; i++ {
			var tel telrec
			if err := telemetryStatsMap.Lookup(uint32(i), &tel); err != nil {
				fmt.Printf("Failed to get telemetry data for key %d: %v\n", i, err)
				continue
			}
			if tel.ProcessingTime != 0 {
				processingTime = int64(tel.ProcessingTime)
			}
		}

		// Calculate elapsed time from start
		elapsed := time.Since(startTime).Seconds()

		// Record each data point for CSV output
		record := []string{
			fmt.Sprintf("%.2f", elapsed),
			fmt.Sprintf("%d", dropped),
			fmt.Sprintf("%d", passed),
			fmt.Sprintf("%d", processingTime),
			fmt.Sprintf("%.2f", rps),
		}

		if err := writer.Write(record); err != nil {
			fmt.Printf("Failed to write record to CSV: %v\n", err)
			return
		}

		// Print stats to console
		fmt.Printf("Elapsed: %.2f, Dropped: %d, Passed: %d, ProcessingTime: %d, RPS: %.2f\n",
			elapsed, dropped, passed, processingTime, rps)

		writer.Flush() // Flush after each write

		time.Sleep(2 * time.Second) // Poll every 2 seconds
	}
}
