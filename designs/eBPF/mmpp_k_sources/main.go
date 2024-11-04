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

	XDP_MAX_SOURCES = 5
	SCALE           = 1000
)

type xdpStats struct {
	RxPackets   uint64
	ServiceRate uint64
	QueueSize   uint64
}

type shaperStats struct {
	WindowStart uint64
	NAverage    uint64
	NArrivals   uint64
}

func main() {
	interfaceName := flag.String("iface", "", "Network interface for XDP")
	flag.Parse()

	if *interfaceName == "" {
		fmt.Println("No interface specified. Usage: -iface <interface-name>")
		os.Exit(1)
	}

	iface, err := net.InterfaceByName(*interfaceName)
	if err != nil {
		fmt.Printf("Failed to get interface %s: %v\n", *interfaceName, err)
		return
	}

	spec, err := ebpf.LoadCollectionSpec("./c/kern.o")
	if err != nil {
		fmt.Printf("Failed to load collection spec: %v\n", err)
		return
	}

	coll, err := ebpf.NewCollection(spec)
	if err != nil {
		fmt.Printf("Failed to create collection: %v\n", err)
		return
	}
	defer coll.Close()

	prog := coll.Programs["xdp_mmpp_shaper"]
	if prog == nil {
		fmt.Println("Program 'xdp_mmpp_shaper' not found in the collection")
		return
	}

	opts := link.XDPOptions{
		Program:   prog,
		Interface: iface.Index,
	}
	lnk, err := link.AttachXDP(opts)
	if err != nil {
		fmt.Printf("Failed to attach XDP program: %v\n", err)
		return
	}
	defer lnk.Close()

	xdpStatsMap, ok := coll.Maps["xdp_stats_map"]
	if !ok {
		fmt.Println("No map named 'xdp_stats_map' found")
		return
	}

	shaperStatsMap, ok := coll.Maps["shaper_stats_map"]
	if !ok {
		fmt.Println("No map named 'shaper_stats_map' found")
		return
	}

	startTimestamp := uint64(time.Now().UnixNano()) // Get current time for window_start

	for i := 0; i < XDP_MAX_SOURCES; i++ {
		xdpStat := xdpStats{RxPackets: 0, ServiceRate: 0, QueueSize: 0}
		if err := xdpStatsMap.Update(uint32(i), &xdpStat, ebpf.UpdateAny); err != nil {
			fmt.Printf("Failed to initialize xdp_stats_map for key %d: %v\n", i, err)
			return
		}
	}

	for i := 0; i < XDP_MAX_SOURCES; i++ {
		shaperStat := shaperStats{
			WindowStart: startTimestamp,
			NAverage:    SCALE, // Initialize n_average to SCALE as baseline
			NArrivals:   0,
		}
		if err := shaperStatsMap.Update(uint32(i), &shaperStat, ebpf.UpdateAny); err != nil {
			fmt.Printf("Failed to initialize shaper_stats_map for key %d: %v\n", i, err)
			return
		}
	}
	fmt.Println("Successfully loaded and attached BPF program and populated maps")

	go collectStats(xdpStatsMap, shaperStatsMap)

	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c
}

func collectStats(xdpStatsMap *ebpf.Map, shaperStatsMap *ebpf.Map) {
	startTime := time.Now()

	file, err := os.Create("stats.csv")
	if err != nil {
		fmt.Printf("Failed to create CSV file: %v\n", err)
		return
	}
	defer file.Close()

	writer := csv.NewWriter(file)
	defer writer.Flush()

	if err := writer.Write([]string{"Time", "Dropped", "Passed", "ServiceRate", "NAverage", "QueueSize"}); err != nil {
		fmt.Printf("Failed to write CSV header: %v\n", err)
		return
	}

	for {
		var dropped, passed, totalRxPackets int64

		for i := 0; i < XDP_MAX_SOURCES; i++ {
			var xdpStat xdpStats
			var shaperStat shaperStats

			if err := xdpStatsMap.Lookup(uint32(i), &xdpStat); err != nil {
				fmt.Printf("Failed to lookup xdp_stats_map for key %d: %v\n", i, err)
				continue
			}
			if err := shaperStatsMap.Lookup(uint32(i), &shaperStat); err != nil {
				fmt.Printf("Failed to lookup shaper_stats_map for key %d: %v\n", i, err)
				continue
			}

			totalRxPackets += int64(xdpStat.RxPackets)
			if i == TYPE_DROP {
				dropped += int64(xdpStat.RxPackets)
			} else if i == TYPE_PASS {
				passed += int64(xdpStat.RxPackets)
			}

			serviceRate := int64(xdpStat.ServiceRate)
			nAverage := int64(shaperStat.NAverage)
			queueSize := int64(xdpStat.QueueSize)
			windowStart := int64(shaperStat.WindowStart)

			elapsed := time.Since(startTime).Seconds()
			record := []string{
				fmt.Sprintf("%.2f", elapsed),
				fmt.Sprintf("%d", dropped),
				fmt.Sprintf("%d", passed),
				fmt.Sprintf("%d", serviceRate),
				fmt.Sprintf("%d", nAverage),
				fmt.Sprintf("%d", queueSize),
				fmt.Sprintf("%d", windowStart),
			}

			if err := writer.Write(record); err != nil {
				fmt.Printf("Failed to write record to CSV: %v\n", err)
				return
			}

			fmt.Printf(
				"Elapsed: %.2f, Dropped: %d, Passed: %d, ServiceRate: %d, NAverage: %d, QueueSize: %d, WindowStart: %d\n",
				elapsed,
				dropped,
				passed,
				serviceRate,
				nAverage,
				queueSize,
				windowStart,
			)
		}

		fmt.Printf("\n")

		writer.Flush()
		time.Sleep(2 * time.Second)
	}
}
