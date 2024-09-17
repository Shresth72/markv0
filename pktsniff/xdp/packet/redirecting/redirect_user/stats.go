package main

import (
	"fmt"
	"time"

	"github.com/cilium/ebpf"
)

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

func collectTelemetryStats(telemetryStatsMap *ebpf.Map) {
	for {
		fmt.Println("Collecting telemetry stats from telemetryStatsMap:")
		for i := 0; i < 5; i++ {
			var tel telrec
			if err := telemetryStatsMap.Lookup(uint32(i), &tel); err != nil {
				fmt.Printf("Failed to get telemetry data for key %d: %v\n", i, err)
				continue
			}

			// Print only if timestamp is not zero
			if tel.Timestamp != 0 {
				// Assuming timestamp is in nanoseconds since Unix epoch
				timestamp := time.Unix(0, int64(tel.Timestamp))
				// Format timestamp
				_ = timestamp.Format("2006-01-02 15:04:05.999999999")
				date := timestamp.Format("2006-01-02")
				timePart := timestamp.Format("15:04:05.999999999")

				fmt.Printf(
					"Date: %s, Time: %s, Processing Time: %d nanos\n",
					date,
					timePart,
					tel.ProcessingTime,
				)
			}
		}
		fmt.Println()
		time.Sleep(2 * time.Second) // Poll every 2 seconds
	}
}
