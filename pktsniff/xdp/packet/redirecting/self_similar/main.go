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

	if windowStartMap == nil || packetCountMap == nil || averageCountMap == nil ||
		queueSizeMap == nil {
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

	// Open CSV file for logging
	file, err := os.OpenFile("traffic_data.csv", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
	if err != nil {
		panic(fmt.Sprintf("Failed to open CSV file: %v", err))
	}
	defer file.Close()

	writer := csv.NewWriter(file)
	defer writer.Flush()

	// Log header
	writer.Write([]string{"Timestamp", "Packet Count", "Average Count", "Queue Size"})

	go func() {
		for {
			time.Sleep(1 * time.Second) // Log every second

			// Read current values from maps
			var packetCountVal uint64
			var averageCountVal uint64
			var queueSizeVal uint64

			if err := packetCountMap.Lookup(&key, &packetCountVal); err != nil {
				packetCountVal = 0 // Default to 0 if lookup fails
			}
			if err := averageCountMap.Lookup(&key, &averageCountVal); err != nil {
				averageCountVal = 0 // Default to 0 if lookup fails
			}
			if err := queueSizeMap.Lookup(&key, &queueSizeVal); err != nil {
				queueSizeVal = 0 // Default to 0 if lookup fails
			}

			// Write to CSV
			record := []string{
				time.Now().Format(time.RFC3339),
				fmt.Sprintf("%d", packetCountVal),
				fmt.Sprintf("%d", averageCountVal),
				fmt.Sprintf("%d", queueSizeVal),
			}

			fmt.Printf(
				"Elapsed: %d, PacketCount: %d, AverageCount: %d, queueSize: %d\n",
				time.Now().Format(time.RFC3339),
				fmt.Sprintf("%d", packetCountVal),
				fmt.Sprintf("%d", averageCountVal),
				fmt.Sprintf("%d", queueSizeVal),
			)

			writer.Write(record)
		}
	}()
	fmt.Println("Successfully loaded and attached XDP program for self-similar traffic shaping")

	// Wait for a signal to exit
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c
}
