package main

import (
	"bytes"
	"encoding/binary"
	"flag"
	"fmt"
	"net"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/cilium/ebpf"
	"github.com/cilium/ebpf/link"
	"github.com/cilium/ebpf/perf"
)

const (
	TYPE_ENTER = 1
	TYPE_DROP  = 2
	TYPE_PASS  = 3
	MAX_STATES = 256
	THRESHOLD  = 0.01
)

type event struct {
	TimeSinceBoot  uint64
	ProcessingTime uint32
	Type           uint8
	Protocol       uint8
	SrcPort        uint16
	DstPort        uint16
}

type MarkovChain struct {
	transitionCounts [MAX_STATES][MAX_STATES]uint32
	currentState     uint32
}

func (mc *MarkovChain) updateState(newState uint32) {
	mc.transitionCounts[mc.currentState][newState]++
	mc.currentState = newState
}

func (mc *MarkovChain) getTransitionProbabilities() [MAX_STATES][MAX_STATES]float64 {
	var probs [MAX_STATES][MAX_STATES]float64
	for i := 0; i < MAX_STATES; i++ {
		var sum uint32
		for j := 0; j < MAX_STATES; j++ {
			sum += mc.transitionCounts[i][j]
		}
		if sum > 0 {
			for j := 0; j < MAX_STATES; j++ {
				probs[i][j] = float64(mc.transitionCounts[i][j]) / float64(sum)
			}
		}
	}
	return probs
}

func (mc *MarkovChain) detectAnomalies() []string {
	probs := mc.getTransitionProbabilities()
	var anomalies []string
	for i := 0; i < MAX_STATES; i++ {
		for j := 0; j < MAX_STATES; j++ {
			if probs[i][j] > 0 && probs[i][j] < THRESHOLD {
				anomalies = append(
					anomalies,
					fmt.Sprintf(
						"Anomaly detected: Unusual transition from state %d to %d (probability: %f)",
						i,
						j,
						probs[i][j],
					),
				)
			}
		}
	}
	return anomalies
}

func getState(e event) uint32 {
	return (uint32(e.Protocol*17) + uint32(e.SrcPort*13) + uint32(e.DstPort*11)) % MAX_STATES
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

	spec, err := ebpf.LoadCollectionSpec("../../markov.o")
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

	mc := &MarkovChain{}

	go func() {
		for {
			record, err := perfEvent.Read()
			if err != nil {
				fmt.Println(err)
				continue
			}

			var e event
			// if len(record.RawSample) < 17 {
			// 	fmt.Println("Invalid sample size")
			// 	continue
			// }
			//
			// e.TimeSinceBoot = binary.LittleEndian.Uint64(record.RawSample[:8])
			// e.ProcessingTime = binary.LittleEndian.Uint32(record.RawSample[8:12])
			// e.Type = uint8(record.RawSample[12])
			// e.Protocol = uint8(record.RawSample[13])
			// e.SrcPort = binary.LittleEndian.Uint16(record.RawSample[14:16])
			// e.DstPort = binary.LittleEndian.Uint16(record.RawSample[16:18])

			if err := binary.Read(bytes.NewReader(record.RawSample), binary.LittleEndian, &e); err != nil {
				fmt.Println("Failed to parse event:", err)
				continue
			}

			newState := getState(e)
			mc.updateState(newState)
		}
	}()

	go func() {
		for {
			time.Sleep(60 * time.Second)
			anomalies := mc.detectAnomalies()
			if len(anomalies) > 0 {
				fmt.Print("\033[H\033[2J")
				fmt.Println("Anomalies detected:")
				for _, anomaly := range anomalies {
					fmt.Println(anomaly)
				}
			}
		}
	}()

	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c
}
