package utils

import (
	// "encoding/binary"
	"flag"
	"fmt"
	"net"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/cilium/ebpf"
	"github.com/cilium/ebpf/link"
	// "github.com/cilium/ebpf/perf"
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

type event struct {
	TimeSinceBoot  uint64
	ProcessingTime uint32
	Type           uint8
}

const ringBufferSize = 128

type ringBuffer struct {
	data    [ringBufferSize]uint32
	start   int
	pointer int
	filled  bool
}

func (rb *ringBuffer) add(val uint32) {
	if rb.pointer < ringBufferSize {
		rb.pointer++
	} else {
		rb.filled = true
		rb.pointer = 1
	}
	rb.data[rb.pointer-1] = val
}

func (rb *ringBuffer) avg() float32 {
	if rb.pointer == 0 {
		return 0
	}

	sum := uint32(0)
	for _, val := range rb.data {
		sum += val
	}

	if rb.filled {
		return float32(sum) / float32(ringBufferSize)
	}
	return float32(sum) / float32(rb.pointer)
}

func parseMAC(macStr string) [ETH_ALEN]byte {
	var mac [ETH_ALEN]byte
	for i := 0; i < ETH_ALEN; i++ {
		fmt.Sscanf(macStr[i*3:i*3+2], "%2hhx", &mac[i])
	}
	return mac
}

func collectStats(xdpStatsMap *ebpf.Map) {
	// Map action type to human-readable action names
	actionNames := map[int]string{
		0: "XDP_ABORTED  ",
		1: "XDP_DROP     ",
		2: "XDP_PASS     ",
		3: "XDP_TX       ",
		4: "XDP_REDIRECT ",
	}

	for {
		fmt.Println("Collecting stats from xdpStatsMap:")
		for i := 0; i < 5; i++ {
			var stats datarec
			if err := xdpStatsMap.Lookup(uint32(i), &stats); err != nil {
				fmt.Printf("Failed to get stats for key %d: %v\n", i, err)
				continue
			}

			// Get action name, default to "UNKNOWN" if not found
			actionName, ok := actionNames[i]
			if !ok {
				actionName = "UNKNOWN"
			}

			fmt.Printf(
				"Action %s: Packets: %d, Bytes: %d\n",
				actionName,
				stats.RxPackets,
				stats.RxBytes,
			)
		}
		fmt.Println()
		time.Sleep(2 * time.Second) // Poll every 2 seconds
	}
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

	fmt.Println("Successfully loaded and attached BPF program and populated maps")

	// Perf event handling
	// perfEvent, err := perf.NewReader(coll.Maps["events"], os.Getpagesize())
	// if err != nil {
	// 	panic(fmt.Sprintf("Failed to create perf event reader: %v\n", err))
	// }
	// defer perfEvent.Close()
	//
	// buckets := map[uint8]uint32{
	// 	TYPE_ENTER: 0,
	// 	TYPE_DROP:  0,
	// 	TYPE_PASS:  0,
	// }
	// processingTimePassed := &ringBuffer{}
	// processingTimeDropped := &ringBuffer{}
	//
	// go func() {
	// 	for {
	// 		record, err := perfEvent.Read()
	// 		if err != nil {
	// 			fmt.Println(err)
	// 			continue
	// 		}
	//
	// 		var e event
	// 		if len(record.RawSample) < 12 {
	// 			fmt.Println("Invalid sample size")
	// 			continue
	// 		}
	//
	// 		// Parse the event data
	// 		e.TimeSinceBoot = binary.LittleEndian.Uint64(record.RawSample[:8])
	// 		e.ProcessingTime = binary.LittleEndian.Uint32(record.RawSample[8:12])
	// 		e.Type = uint8(record.RawSample[12])
	//
	// 		// Sanity check: Ensure event type is within a valid range
	// 		switch e.Type {
	// 		case TYPE_ENTER, TYPE_DROP, TYPE_PASS:
	// 			buckets[e.Type]++ // Increment packet count based on type
	//
	// 			// Accumulate processing times for DROP and PASS actions
	// 			if e.Type == TYPE_DROP {
	// 				processingTimeDropped.add(e.ProcessingTime)
	// 			} else if e.Type == TYPE_PASS {
	// 				processingTimePassed.add(e.ProcessingTime)
	// 			}
	//
	// 		default:
	// 			// If event type is not recognized, skip processing
	// 			// fmt.Printf("Unknown event type: %d\n", e.Type)
	// 			continue
	// 		}
	//
	// 		// Clear terminal screen and print updated stats
	// 		fmt.Print("\033[H\033[2J")
	// 		fmt.Printf(
	// 			"total: %d. passed: %d. dropped: %d. passed processing time avg (ns): %f. dropped processing time avg (ns): %f\n",
	// 			buckets[TYPE_ENTER],
	// 			buckets[TYPE_PASS],
	// 			buckets[TYPE_DROP],
	// 			processingTimePassed.avg(),
	// 			processingTimeDropped.avg(),
	// 		)
	// 	}
	// }()

	// Periodically collect stats from xdpStatsMap
	go collectStats(xdpStatsMap)

	// Signal handling
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c
}
