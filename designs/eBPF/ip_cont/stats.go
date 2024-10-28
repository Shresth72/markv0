package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"time"

	"github.com/cilium/ebpf"
)

var droppedPackets, passedPackets []int64
var processingTimes []uint64

func collectStats(xdpStatsMap *ebpf.Map, telemetryStatsMap *ebpf.Map) {
	startTime := time.Now()

	// Create or open the CSV file
	file, err := os.Create("stats.csv")
	if err != nil {
		fmt.Printf("Failed to create CSV file: %v\n", err)
		return
	}
	defer file.Close()

	writer := csv.NewWriter(file)
	defer writer.Flush()

	// Write header
	if err := writer.Write([]string{"Time", "Dropped", "Passed", "ProcessingTime"}); err != nil {
		fmt.Printf("Failed to write header to CSV: %v\n", err)
		return
	}

	for {
		var dropped, passed int64

		for i := 0; i < 5; i++ {
			var stats datarec
			if err := xdpStatsMap.Lookup(uint32(i), &stats); err != nil {
				fmt.Printf("Failed to get stats for key %d: %v\n", i, err)
				continue
			}

			if i == 1 { // XDP_DROP
				dropped += int64(stats.RxPackets)
			} else if i == 2 { // XDP_PASS
				passed += int64(stats.RxPackets)
			}
		}

		droppedPackets = append(droppedPackets, dropped)
		passedPackets = append(passedPackets, passed)

		// Collect processing times from telemetryStatsMap
		for i := 0; i < 5; i++ {
			var tel telrec
			if err := telemetryStatsMap.Lookup(uint32(i), &tel); err != nil {
				fmt.Printf("Failed to get telemetry data for key %d: %v\n", i, err)
				continue
			}

			if tel.Timestamp != 0 {
				processingTimes = append(processingTimes, tel.ProcessingTime)
			}
		}

		elapsed := time.Since(startTime).Seconds()
		processingTime := int64(0) // Default value

		if len(processingTimes) > 0 {
			processingTime = int64(processingTimes[len(processingTimes)-1])
		}

		record := []string{
			fmt.Sprintf("%.2f", elapsed),
			fmt.Sprintf("%d", dropped),
			fmt.Sprintf("%d", passed),
			fmt.Sprintf("%d", processingTime),
		}

		if err := writer.Write(record); err != nil {
			fmt.Printf("Failed to write record to CSV: %v\n", err)
			return
		}

		fmt.Printf(
			"Elapsed: %.2f, Dropped: %d, Passed: %d, ProcessingTime: %d\n",
			elapsed,
			dropped,
			passed,
			processingTime,
		)

		writer.Flush() // Flush after each write

		time.Sleep(2 * time.Second) // Poll every 2 seconds
	}
}
