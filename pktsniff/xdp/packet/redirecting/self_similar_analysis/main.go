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
	// Constants for MMPP parameters
	numSources       = 4
	lambda1          = 1000 // Example intensity for state 1
	lambda2          = 500  // Example intensity for state 2
	transitionRateC1 = 0.1  // Example transition rate from state 2 to state 1
	transitionRateC2 = 0.1  // Example transition rate from state 1 to state 2
)

type DataRec struct {
	RxPackets      uint64 `ebpf:"rx_packets"`
	RxBytes        uint64 `ebpf:"rx_bytes"`
	TxPackets      uint64 `ebpf:"tx_packets"`
	TxBytes        uint64 `ebpf:"tx_bytes"`
	DroppedPackets uint64 `ebpf:"dropped_packets"`
	Lambda         uint64 `ebpf:"lambda"`
	CurrentState   uint64 `ebpf:"current_state"`
	LastUpdate     uint64 `ebpf:"last_update"`
}

func main() {
	interfaceName := flag.String("interface", "", "Network interface to attach XDP program")
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

	prog := coll.Programs["xdp_traffic_shaper"]
	if prog == nil {
		panic("No program named 'xdp_traffic_shaper' found in collection")
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

	// Initialize maps
	windowStartMap := coll.Maps["window_start"]
	packetCountMap := coll.Maps["packet_count"]
	averageCountMap := coll.Maps["average_count"]
	queueSizeMap := coll.Maps["queue_size"]
	mmppSourcesMap := coll.Maps["mmpp_sources"]
	xdpStatsMap := coll.Maps["xdp_stats_map"]

	if windowStartMap == nil || packetCountMap == nil || averageCountMap == nil ||
		queueSizeMap == nil || mmppSourcesMap == nil || xdpStatsMap == nil {
		panic("Failed to get required maps")
	}

	// Initialize map values
	key := uint32(0)
	initialWindowStart := uint64(0)
	initialPacketCount := uint64(0)
	initialAverageCount := uint64(1000) // Initial average of 1000 packets per second
	initialQueueSize := uint64(0)

	if err := windowStartMap.Update(&key, &initialWindowStart, ebpf.UpdateAny); err != nil {
		panic(fmt.Sprintf("Failed to initialize window_start map: %v", err))
	}
	if err := packetCountMap.Update(&key, &initialPacketCount, ebpf.UpdateAny); err != nil {
		panic(fmt.Sprintf("Failed to initialize packet_count map: %v", err))
	}
	if err := averageCountMap.Update(&key, &initialAverageCount, ebpf.UpdateAny); err != nil {
		panic(fmt.Sprintf("Failed to initialize average_count map: %v", err))
	}
	if err := queueSizeMap.Update(&key, &initialQueueSize, ebpf.UpdateAny); err != nil {
		panic(fmt.Sprintf("Failed to initialize queue_size map: %v", err))
	}

	// Populate mmpp_sources map
	for i := 0; i < numSources; i++ {
		sourceKey := uint32(i)
		source := struct {
			Lambda1        uint64
			Lambda2        uint64
			C1             uint64
			C2             uint64
			CurrentState   uint64
			LastTransition uint64
		}{
			Lambda1:        lambda1,
			Lambda2:        lambda2,
			C1:             uint64(transitionRateC1 * 1000), // Scale for fixed-point
			C2:             uint64(transitionRateC2 * 1000), // Scale for fixed-point
			CurrentState:   1,                               // Start in state 1
			LastTransition: 0,
		}

		if err := mmppSourcesMap.Update(&sourceKey, &source, ebpf.UpdateAny); err != nil {
			panic(fmt.Sprintf("Failed to initialize mmpp_sources map for source %d: %v", i, err))
		}
	}

	// Open CSV file for logging
	file, err := os.OpenFile("traffic_data.csv", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
	if err != nil {
		panic(fmt.Sprintf("Failed to open CSV file: %v", err))
	}
	defer file.Close()

	writer := csv.NewWriter(file)
	defer writer.Flush()

	// Log header including the new XDP stats
	writer.Write([]string{
		"Timestamp", "Packet Count", "Average Count", "Queue Size",
		"Rx Packets", "Rx Bytes", "Tx Packets", "Tx Bytes", "Dropped Packets",
		"Lambda", "Current State", "Last Update",
	})

	go func() {
		for {
			time.Sleep(1 * time.Second) // Log every second

			// Read current values from maps
			var packetCountVal uint64
			var averageCountVal uint64
			var queueSizeVal uint64

			// XDP stats data from xdp_stats_map
			var stats DataRec

			if err := packetCountMap.Lookup(&key, &packetCountVal); err != nil {
				packetCountVal = 0 // Default to 0 if lookup fails
			}
			if err := averageCountMap.Lookup(&key, &averageCountVal); err != nil {
				averageCountVal = 0 // Default to 0 if lookup fails
			}
			if err := queueSizeMap.Lookup(&key, &queueSizeVal); err != nil {
				queueSizeVal = 0 // Default to 0 if lookup fails
			}
			if err := xdpStatsMap.Lookup(&key, &stats); err != nil {
				fmt.Printf("Failed to lookup xdp_stats_map: %v\n", err)
				continue
			}

			// Print stats to the console
			fmt.Printf(
				"Elapsed: %s, PacketCount: %d, AverageCount: %d, QueueSize: %d, "+
					"RxPackets: %d, RxBytes: %d, TxPackets: %d, TxBytes: %d, DroppedPackets: %d, "+
					"Lambda: %d, CurrentState: %d, LastUpdate: %d\n",
				time.Now().Format(time.RFC3339),
				packetCountVal,
				averageCountVal,
				queueSizeVal,
				stats.RxPackets,
				stats.RxBytes,
				stats.TxPackets,
				stats.TxBytes,
				stats.DroppedPackets,
				stats.Lambda,
				stats.CurrentState,
				stats.LastUpdate,
			)

			// Write to CSV
			record := []string{
				time.Now().Format(time.RFC3339),
				fmt.Sprintf("%d", packetCountVal),
				fmt.Sprintf("%d", averageCountVal),
				fmt.Sprintf("%d", queueSizeVal),
				fmt.Sprintf("%d", stats.RxPackets),
				fmt.Sprintf("%d", stats.RxBytes),
				fmt.Sprintf("%d", stats.TxPackets),
				fmt.Sprintf("%d", stats.TxBytes),
				fmt.Sprintf("%d", stats.DroppedPackets),
				fmt.Sprintf("%d", stats.Lambda),
				fmt.Sprintf("%d", stats.CurrentState),
				fmt.Sprintf("%d", stats.LastUpdate),
			}

			writer.Write(record)
		}
	}()
	fmt.Println(
		"Successfully loaded and attached XDP program for self-similar traffic shaping with stats logging",
	)

	// Wait for a signal to exit
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c
}
