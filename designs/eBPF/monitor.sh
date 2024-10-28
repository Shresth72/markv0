#!/bin/bash

# Network Interface Traffic Monitor with Packet Statistics
# Usage: ./network_monitor.sh <interface> <duration_seconds>

interface="${1:-eth0}"  # Default to eth0 if no interface specified
duration="${2:-60}"     # Default to 60 seconds if no duration specified

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Validate interface exists
if ! ip link show "$interface" >/dev/null 2>&1; then
    echo "Interface $interface does not exist"
    exit 1
fi

echo "Starting network monitor on $interface for $duration seconds"
echo "Monitoring traffic statistics..."

# Get initial counters
initial_rx=$(cat /sys/class/net/"$interface"/statistics/rx_bytes)
initial_tx=$(cat /sys/class/net/"$interface"/statistics/tx_bytes)
initial_rx_packets=$(cat /sys/class/net/"$interface"/statistics/rx_packets)
initial_tx_packets=$(cat /sys/class/net/"$interface"/statistics/tx_packets)
start_time=$(date +%s)
last_rx=$initial_rx
last_tx=$initial_tx
last_rx_packets=$initial_rx_packets
last_tx_packets=$initial_tx_packets
last_time=$start_time

# Monitor loop
while [ $(( $(date +%s) - start_time )) -lt "$duration" ]; do
    sleep 1
    clear
    
    current_time=$(date +%s)
    current_rx=$(cat /sys/class/net/"$interface"/statistics/rx_bytes)
    current_tx=$(cat /sys/class/net/"$interface"/statistics/tx_bytes)
    current_rx_packets=$(cat /sys/class/net/"$interface"/statistics/rx_packets)
    current_tx_packets=$(cat /sys/class/net/"$interface"/statistics/tx_packets)
    
    # Calculate rates only if time has passed
    time_diff=$(( current_time - last_time ))
    if [ "$time_diff" -gt 0 ]; then
        rx_rate=$(( (current_rx - last_rx) / time_diff ))
        tx_rate=$(( (current_tx - last_tx) / time_diff ))
        rx_pps=$(( (current_rx_packets - last_rx_packets) / time_diff ))
        tx_pps=$(( (current_tx_packets - last_tx_packets) / time_diff ))
    else
        rx_rate=0
        tx_rate=0
        rx_pps=0
        tx_pps=0
    fi
    
    # Update last values
    last_rx=$current_rx
    last_tx=$current_tx
    last_rx_packets=$current_rx_packets
    last_tx_packets=$current_tx_packets
    last_time=$current_time
    
    total_elapsed=$(( current_time - start_time ))
    
    echo "Interface: $interface"
    echo "Time elapsed: $total_elapsed seconds"
    echo "----------------------------"
    echo "Bandwidth Stats:"
    echo "RX Rate: $(( rx_rate / 1024 )) KB/s"
    echo "TX Rate: $(( tx_rate / 1024 )) KB/s"
    echo "Total RX: $(( (current_rx - initial_rx) / 1024 )) KB"
    echo "Total TX: $(( (current_tx - initial_tx) / 1024 )) KB"
    echo "----------------------------"
    echo "Packet Stats:"
    echo "RX Packets/sec: $rx_pps pps"
    echo "TX Packets/sec: $tx_pps pps"
    echo "Total RX Packets: $(( current_rx_packets - initial_rx_packets ))"
    echo "Total TX Packets: $(( current_tx_packets - initial_tx_packets ))"
    echo "----------------------------"
    echo "Press Ctrl+C to stop"
done

echo "Monitoring complete"
