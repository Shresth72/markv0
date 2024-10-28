package main

import (
	"bytes"
	"encoding/binary"
	"encoding/csv"
	"log"
	"net"
	"os"
	"os/signal"
	"strconv"
	"syscall"
	"time"

	"github.com/cilium/ebpf"
	"github.com/cilium/ebpf/link"
)

const (
	MAX_SOURCES      = 4
	MAX_QUEUE_LENGTH = 1000
)

// Define the eBPF structure for the source state
type SourceState struct {
	Active          uint64
	Intensity1      uint64
	Intensity2      uint64
	TransitionRate1 uint64
	TransitionRate2 uint64
	LastTransition  uint64
}

func main() {
	// Load the compiled eBPF object
	spec, err := ebpf.LoadCollectionSpec("./c/kern.o")
	if err != nil {
		log.Fatalf("Failed to load eBPF spec: %v", err)
	}

	collection, err := ebpf.NewCollection(spec)
	if err != nil {
		log.Fatalf("Failed to load eBPF collection: %v", err)
	}
	defer collection.Close()

	intf, err := net.InterfaceByName("cni0")
	if err != nil {
		log.Fatalf("could not find interface %s: %v", "cni0", err)
	}
	intfIndex := intf.Index

	link, err := link.AttachXDP(link.XDPOptions{
		Program:   collection.Programs["xdp_redirect_map_func"],
		Interface: intfIndex,           // Replace with the correct interface
		Flags:     link.XDPGenericMode, // Or link.XDPDriverMode
	})
	if err != nil {
		log.Fatalf("Failed to attach XDP program: %v", err)
	}
	defer link.Close()

	sourceStates := collection.Maps["source_states"]
	queueLengthMap := collection.Maps["queue_length_map"]

	for i := uint32(0); i < MAX_SOURCES; i++ {
		source := SourceState{
			Active:          1,   // Initially active
			Intensity1:      100, // Example intensity1 value
			Intensity2:      50,  // Example intensity2 value
			TransitionRate1: 10,  // Example transition rates in seconds
			TransitionRate2: 20,
			LastTransition:  uint64(time.Now().UnixNano()),
		}
		err := sourceStates.Put(i, &source)
		if err != nil {
			log.Fatalf("Failed to add source state: %v", err)
		}
	}

	file, err := os.Create("queue_length_data.csv")
	if err != nil {
		log.Fatalf("Failed to create CSV file: %v", err)
	}
	defer file.Close()

	writer := csv.NewWriter(file)
	defer writer.Flush()
	writer.Write([]string{"Time", "Queue Length"})

	// Monitor queue length and adaptively shape traffic
	go monitorQueueLength(queueLengthMap, writer)

	sig := make(chan os.Signal, 1)
	signal.Notify(sig, syscall.SIGINT, syscall.SIGTERM)
	<-sig

	log.Println("Detaching eBPF program and exiting...")
}

func monitorQueueLength(queueLengthMap *ebpf.Map, writer *csv.Writer) {
	var queueLength uint64
	key := uint32(0)

	for {
		err := queueLengthMap.Lookup(&key, &queueLength)
		if err != nil {
			log.Printf("Failed to get queue length: %v", err)
		} else {
			currentTime := time.Now().Format(time.RFC3339)
			writer.Write([]string{currentTime, strconv.FormatUint(queueLength, 10)})
			writer.Flush()

			log.Printf("Current queue length: %d", queueLength)
		}

		// Sleep before polling again
		time.Sleep(1 * time.Second)
	}
}

func toBytes(data interface{}) ([]byte, error) {
	buf := new(bytes.Buffer)
	err := binary.Write(buf, binary.LittleEndian, data)
	return buf.Bytes(), err
}
