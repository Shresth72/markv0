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
	"github.com/cilium/ebpf/perf"
)

const (
	TYPE_ENTER = 1
	TYPE_DROP  = 2
	TYPE_PASS  = 3
)

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

func main() {
	interfaceName := flag.String("interface", "", "Network interface to attach XDP program")
	flag.Parse()

	if *interfaceName == "" {
		fmt.Println(
			"No interface specified. Use the -interface flag to specify the network interface.",
		)
		os.Exit(1)
	}

	spec, err := ebpf.LoadCollectionSpec("../kern.o")
	if err != nil {
		panic(err)
	}

	coll, err := ebpf.NewCollection(spec)
	if err != nil {
		panic(fmt.Sprintf("Failed to create new collection: %v\n", err))
	}
	defer coll.Close()

	prog := coll.Programs["xdp_lib"]
	if prog == nil {
		panic("No program named 'xdp_kern' found in collection")
	}

	iface_idx, err := net.InterfaceByName(*interfaceName)
	if err != nil {
		panic(fmt.Sprintf("Failed to get interface %s: %v\n", *interfaceName, err))
	}

	opts := link.XDPOptions{
		Program:   prog,
		Interface: iface_idx.Index,
	}
	lnk, err := link.AttachXDP(opts)
	if err != nil {
		panic(err)
	}
	defer lnk.Close()

	fmt.Println("Successfully loaded and attached BPF program")

	outputMap, ok := coll.Maps["output_map"]
	if !ok {
		panic("No map named 'output_map' found in collection")
	}

	perfEvent, err := perf.NewReader(outputMap, 4096)
	if err != nil {
		panic(fmt.Sprintf("Failed to create perf event reader: %v\n", err))
	}
	defer perfEvent.Close()

	buckets := map[uint8]uint32{
		TYPE_ENTER: 0,
		TYPE_DROP:  0,
		TYPE_PASS:  0,
	}
	processingTimePassed := &ringBuffer{}
	processingTimeDropped := &ringBuffer{}

	go func() {
		for {
			record, err := perfEvent.Read()
			if err != nil {
				fmt.Println(err)
				continue
			}

			var e event
			if len(record.RawSample) < 12 {
				fmt.Println("Invalid sample size")
				continue
			}

			// time since boot in the first 8 bytes
			e.TimeSinceBoot = binary.LittleEndian.Uint64(record.RawSample[:8])
			// processing time in the next 4 bytes
			e.ProcessingTime = binary.LittleEndian.Uint32(record.RawSample[8:12])
			// type in the last byte
			e.Type = uint8(record.RawSample[12])
			buckets[e.Type]++
			if e.Type == TYPE_ENTER {
				continue
			}
			if e.Type == TYPE_DROP {
				processingTimeDropped.add(e.ProcessingTime)
			} else if e.Type == TYPE_PASS {
				processingTimePassed.add(e.ProcessingTime)
			}

			fmt.Print("\033[H\033[2J")
			fmt.Printf(
				"total: %d. passed: %d. dropped: %d. passed processing time avg (ns): %f. dropped processing time avg (ns): %f\n",
				buckets[TYPE_ENTER],
				buckets[TYPE_PASS],
				buckets[TYPE_DROP],
				processingTimePassed.avg(),
				processingTimeDropped.avg(),
			)
		}
	}()

	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c
}
