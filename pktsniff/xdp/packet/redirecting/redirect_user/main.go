package main

import (
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

func main() {
	interfaceName := flag.String("interface", "", "Network interface to attach XDP program")
	srcMACStr := flag.String("src-mac", "", "Source MAC address to populate redirect_params")
	destMACStr := flag.String("dest-mac", "", "Destination MAC address to populate redirect_params")
	txPortIndex := flag.Int("tx-port", -1, "Index of the port for tx_port map")
	flag.Parse()

	if *interfaceName == "" {
		fmt.Println(
			"No interface specified. Use the -interface flag to specify the network interface.",
		)
		os.Exit(1)
	}

	spec, err := ebpf.LoadCollectionSpec("../xdp_redirect_to_iface_kern.o")
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

	ifaceIdx, err := net.InterfaceByName(*interfaceName)
	if err != nil {
		panic(fmt.Sprintf("Failed to get interface %s: %v\n", *interfaceName, err))
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

	// Populate redirect_params map
	srcMAC := parseMAC(*srcMACStr)
	destMAC := parseMAC(*destMACStr)

	srcMACKey := [ETH_ALEN]byte{}
	copy(srcMACKey[:], srcMAC[:])
	if err := redirectParamsMap.Update(&srcMACKey, &destMAC, ebpf.UpdateAny); err != nil {
		panic(fmt.Sprintf("Failed to update redirect_params map: %v", err))
	}

	// Populate tx_port map
	if *txPortIndex != -1 {
		if err := txPortMap.Update(uint32(0), uint32(*txPortIndex), ebpf.UpdateAny); err != nil {
			panic(fmt.Sprintf("Failed to update tx_port map: %v", err))
		}
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

	fmt.Println("Successfully loaded and attached BPF program and populated maps")

	// Periodically collect stats from xdpStatsMap and telemetryStatsMap
	go collectStats(xdpStatsMap)
	go collectTelemetryStats(telemetryStatsMap)

	// Signal handling
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c
}
