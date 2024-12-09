package main

import (
	"flag"
	"fmt"
	"net"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/cilium/ebpf"
	"github.com/cilium/ebpf/link"
	"github.com/gorilla/websocket"
)

const (
	TYPE_ENTER      = 1
	TYPE_DROP       = 2
	TYPE_PASS       = 3
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

var upgrader = websocket.Upgrader{}
var clients = make(map[*websocket.Conn]bool)

func main() {
	interfaceName := flag.String("iface", "", "Network interface for XDP")
	flag.Parse()

	if *interfaceName == "" {
		fmt.Println("No interface specified. Usage: -iface <interface-name>")
		os.Exit(1)
	}

	// Load and attach eBPF program
	iface, err := net.InterfaceByName(*interfaceName)
	if err != nil {
		fmt.Printf("Failed to get interface %s: %v\n", *interfaceName, err)
		return
	}

	spec, err := ebpf.LoadCollectionSpec("../c/kern.o")
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

	// Initialize eBPF maps
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

	startTimestamp := uint64(time.Now().UnixNano())

	for i := 0; i < XDP_MAX_SOURCES; i++ {
		xdpStat := xdpStats{RxPackets: 0, ServiceRate: 0, QueueSize: 0}
		if err := xdpStatsMap.Update(uint32(i), &xdpStat, ebpf.UpdateAny); err != nil {
			fmt.Printf("Failed to initialize xdp_stats_map for key %d: %v\n", i, err)
			return
		}
		shaperStat := shaperStats{
			WindowStart: startTimestamp,
			NAverage:    SCALE,
			NArrivals:   0,
		}
		if err := shaperStatsMap.Update(uint32(i), &shaperStat, ebpf.UpdateAny); err != nil {
			fmt.Printf("Failed to initialize shaper_stats_map for key %d: %v\n", i, err)
			return
		}
	}
	fmt.Println("Successfully loaded and attached BPF program and populated maps")

	// Start WebSocket server
	go startWebSocketServer()

	// Start collecting stats
	go collectStats(xdpStatsMap, shaperStatsMap)

	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c
}

func startWebSocketServer() {
	http.HandleFunc("/ws", handleConnections)
	fmt.Println("Starting WebSocket server on port 6969")
	err := http.ListenAndServe(":6969", nil)
	if err != nil {
		fmt.Printf("Failed to start WebSocket server: %v\n", err)
	}
}

func handleConnections(w http.ResponseWriter, r *http.Request) {
	upgrader.CheckOrigin = func(r *http.Request) bool { return true }
	ws, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		fmt.Printf("Failed to upgrade to WebSocket: %v\n", err)
		return
	}
	defer ws.Close()
	clients[ws] = true

	for {
		_, _, err := ws.ReadMessage()
		if err != nil {
			delete(clients, ws)
			break
		}
	}
}

func collectStats(xdpStatsMap *ebpf.Map, shaperStatsMap *ebpf.Map) {
	startTime := time.Now()
	for {
		var dropped, passed int64
		var serviceRate, nAverage, queueSize, windowStart int64

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

			if i == TYPE_DROP {
				dropped += int64(xdpStat.RxPackets)
			} else if i == TYPE_PASS {
				passed += int64(xdpStat.RxPackets)
			}

			serviceRate = int64(xdpStat.ServiceRate)
			nAverage = int64(shaperStat.NAverage)
			queueSize = int64(xdpStat.QueueSize)
			windowStart = int64(shaperStat.WindowStart)
		}

		elapsed := time.Since(startTime).Seconds()
		data := map[string]interface{}{
			"Time":        elapsed,
			"Dropped":     dropped,
			"Passed":      passed,
			"ServiceRate": serviceRate,
			"NAverage":    nAverage,
			"QueueSize":   queueSize,
			"WindowStart": windowStart,
		}

		for client := range clients {
			err := client.WriteJSON(data)
			if err != nil {
				client.Close()
				delete(clients, client)
			}
		}
		time.Sleep(2 * time.Second)
	}
}
