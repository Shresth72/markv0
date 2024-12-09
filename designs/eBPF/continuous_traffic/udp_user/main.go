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
	ETH_ALEN = 6
)

type datarec struct {
	RxPackets uint64
	RxBytes   uint64
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
	queueAvg := 0
	initialIPAT := 0
	logToCSV := true
	flag.Parse()

	if *interfaceName == "" {
		fmt.Println("Error: Network interface not specified. Use the -interface flag.")
		os.Exit(1)
	}

	iface, err := net.InterfaceByName(*interfaceName)
	if err != nil {
		fmt.Printf("Failed to get interface %s: %v\n", *interfaceName, err)
		os.Exit(1)
	}

	// Load eBPF program
	spec, err := ebpf.LoadCollectionSpec("../udp/kern.o")
	if err != nil {
		fmt.Printf("Failed to load eBPF program: %v\n", err)
		os.Exit(1)
	}

	coll, err := ebpf.NewCollection(spec)
	if err != nil {
		fmt.Printf("Failed to create eBPF collection: %v\n", err)
		os.Exit(1)
	}
	defer coll.Close()

	// Attach the program to the interface
	prog := coll.Programs["xdp_redirect_map_func"]
	if prog == nil {
		fmt.Println("Error: Program 'xdp_redirect_map_func' not found in the collection.")
		os.Exit(1)
	}

	lnk, err := link.AttachXDP(link.XDPOptions{
		Program:   prog,
		Interface: iface.Index,
	})
	if err != nil {
		fmt.Printf("Failed to attach XDP program: %v\n", err)
		os.Exit(1)
	}
	defer lnk.Close()

	// Initialize and update maps
	queueAvgMap, ok := coll.Maps["queue_avg_map"]
	if !ok {
		fmt.Println("Error: Map 'queue_avg_map' not found in the collection.")
		os.Exit(1)
	}

	if err := queueAvgMap.Update(uint32(0), queueAvg, ebpf.UpdateAny); err != nil {
		fmt.Printf("Failed to update 'queue_avg_map': %v\n", err)
		os.Exit(1)
	}

	ipatMap, ok := coll.Maps["ipat_map"]
	if !ok {
		fmt.Println("Error: Map 'ipat_map' not found in the collection.")
		os.Exit(1)
	}

	if err := ipatMap.Update(uint32(0), initialIPAT, ebpf.UpdateAny); err != nil {
		fmt.Printf("Failed to update 'ipat_map': %v\n", err)
		os.Exit(1)
	}

	xdpStatsMap, ok := coll.Maps["xdp_stats_map"]
	if !ok {
		fmt.Println("Error: Map 'xdp_stats_map' not found in the collection.")
		os.Exit(1)
	}

	dataRec := datarec{}
	for i := 0; i < 5; i++ {
		if err := xdpStatsMap.Update(uint32(i), &dataRec, ebpf.UpdateAny); err != nil {
			fmt.Printf("Failed to initialize 'xdp_stats_map': %v\n", err)
			os.Exit(1)
		}
	}

	// Start the stats collection goroutine
	go collectStats(xdpStatsMap, ipatMap, logToCSV)

	fmt.Println("eBPF program successfully loaded and attached. Press Ctrl+C to exit.")

	// Signal handling for graceful termination
	signalChan := make(chan os.Signal, 1)
	signal.Notify(signalChan, os.Interrupt, syscall.SIGTERM)
	<-signalChan

	fmt.Println("Detaching and cleaning up resources.")
}

// collectStats collects and logs statistics from the xdp_stats_map and ipat_map.
func collectStats(xdpStatsMap *ebpf.Map, ipatMap *ebpf.Map, logToCSV bool) {
	var dropped, passed uint64

	var file *os.File
	var writer *csv.Writer

	if logToCSV {
		var err error
		file, err = os.Create("stats.csv")
		if err != nil {
			fmt.Printf("Failed to create CSV file: %v\n", err)
			return
		}
		defer file.Close()

		writer = csv.NewWriter(file)
		defer writer.Flush()

		// Write the CSV header
		writer.Write([]string{"Time", "DroppedPackets", "PassedPackets", "InterPacketArrivalTime"})
	}

	startTime := time.Now()
	for {
		dropped, passed = 0, 0

		// Collect statistics from xdp_stats_map
		for i := 0; i < 5; i++ {
			var stats datarec
			if err := xdpStatsMap.Lookup(uint32(i), &stats); err != nil {
				fmt.Printf("Error reading from xdp_stats_map for key %d: %v\n", i, err)
				continue
			}

			if i == 1 { // XDP_DROP
				dropped += stats.RxPackets
			} else if i == 2 { // XDP_PASS
				passed += stats.RxPackets
			}
		}

		// Collect inter-packet arrival time from ipat_map
		var ipat uint64
		if err := ipatMap.Lookup(uint32(0), &ipat); err != nil {
			fmt.Printf("Error reading from ipat_map: %v\n", err)
			ipat = 0 // Default to 0 if error occurs
		}

		elapsed := time.Since(startTime).Seconds()
		fmt.Printf(
			"Time: %.2f, Dropped: %d, Passed: %d, IPAT: %d\n",
			elapsed,
			dropped,
			passed,
			ipat,
		)

		if logToCSV {
			writer.Write([]string{
				fmt.Sprintf("%.2f", elapsed),
				fmt.Sprintf("%d", dropped),
				fmt.Sprintf("%d", passed),
				fmt.Sprintf("%d", ipat),
			})
			writer.Flush()
		}

		time.Sleep(2 * time.Second)
	}
}
