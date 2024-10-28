package main

import (
	"encoding/binary"
	"flag"
	"fmt"
	"net"
	"os"
	"os/signal"
	"syscall"

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
}

func parseMAC(macStr string) [ETH_ALEN]byte {
	var mac [ETH_ALEN]byte
	for i := 0; i < ETH_ALEN; i++ {
		fmt.Sscanf(macStr[i*3:i*3+2], "%2hhx", &mac[i])
	}
	return mac
}

func ipToUint32(ip net.IP) uint32 {
	return binary.BigEndian.Uint32(ip.To4())
}

func main() {
	targetIPStr := flag.String("target-ip", "", "Target server IP address for burst detection")
	interfaceName := flag.String("interface", "", "Network interface to attach XDP program")
	flag.Parse()

	queueAvg := flag.Uint64(
		"q",
		0,
		"Average queue length to populate queue_avg_map",
	)

	if *targetIPStr == "" || *interfaceName == "" {
		fmt.Println("Please specify both -target-ip and -interface.")
		os.Exit(1)
	}

	// Get and convert target IP
	targetIP := net.ParseIP(*targetIPStr)
	if targetIP == nil || targetIP.To4() == nil {
		fmt.Println("Invalid IP address format. Please use IPv4 format.")
		os.Exit(1)
	}

	targetIPUint32 := ipToUint32(targetIP)
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

	// Program and maps
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

	// Get and populate maps
	targetIPMap, ok := coll.Maps["target_ip_map"]
	if !ok {
		panic("No map named 'target_ip_map' found in collection")
	}

	xdpStatsMap, ok := coll.Maps["xdp_stats_map"]
	if !ok {
		panic("No map named 'xdp_stats_map' found in collection")
	}

	telemetryStatsMap, ok := coll.Maps["telemetry_stats_map"]
	if !ok {
		panic("No map named 'telemetry_stats_map' found in collection")
	}

	var key uint32 = 0
	if err := targetIPMap.Update(&key, &targetIPUint32, ebpf.UpdateAny); err != nil {
		panic(fmt.Sprintf("Failed to initialize target_ip_map: %v", err))
	}

	// Initialize datarec for xdp_stats_map
	dataRec := datarec{RxPackets: 0, RxBytes: 0}
	for i := 0; i < 5; i++ { // Assuming XDP_ACTION_MAX is 5
		if err := xdpStatsMap.Update(uint32(i), &dataRec, ebpf.UpdateAny); err != nil {
			panic(fmt.Sprintf("Failed to initialize xdp_stats_map: %v", err))
		}
	}

	// Initialize telrec for telemetry_stats_map
	telRec := telrec{Timestamp: 0, ProcessingTime: 0}
	for i := 0; i < 5; i++ { // Assuming XDP_ACTION_MAX is 5
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

	// Periodically collect stats from xdpStatsMap and telemetryStatsMap
	go collectStats(xdpStatsMap, telemetryStatsMap)

	// Signal handling
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c
}
