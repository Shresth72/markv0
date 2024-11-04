#!/bin/bash

# Network Test Traffic Generator
# Usage: ./traffic_gen.sh <interface> <packet_size> <interval> <duration>

interface="${1:-lo}"           # Default to loopback
packet_size="${2:-64}"        # Default packet size in bytes 
interval="${3:-0.001}"        # Default interval between packets (in seconds)
duration="${4:-60}"           # Default duration in seconds

# Check root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit 1
fi

# Validate interface
if ! ip link show "$interface" >/dev/null 2>&1; then
    echo "Interface $interface does not exist"
    exit 1
fi

# Check for socat
if ! command -v socat >/dev/null 2>&1; then
    echo "socat is required. Please install it with:"
    echo "sudo apt-get install socat  # For Debian/Ubuntu"
    echo "sudo yum install socat      # For RHEL/CentOS"
    exit 1
fi

echo "Starting test traffic generation on $interface"
echo "Packet size: $packet_size bytes"
echo "Interval: $interval seconds"
echo "Duration: $duration seconds"

# Create test data
dd if=/dev/urandom of=/tmp/testdata bs="$packet_size" count=1 2>/dev/null

# Start listener
socat UDP4-LISTEN:12345,bind=0.0.0.0 OPEN:/dev/null,creat &
listener_pid=$!

# Sleep briefly to ensure listener is ready
sleep 0.1

# Cleanup function
cleanup() {
    kill "$listener_pid" 2>/dev/null
    rm -f /tmp/testdata
    echo -e "\nSent $count packets"
    exit 0
}

trap cleanup SIGINT SIGTERM

start_time=$(date +%s)
count=0

# Use socat for sending in a loop
while [ $(( $(date +%s) - start_time )) -lt "$duration" ]; do
    socat -u FILE:/tmp/testdata UDP4:127.0.0.1:12345 2>/dev/null
    count=$((count + 1))
    
    if [ $((count % 100)) -eq 0 ]; then
        echo -ne "\rPackets sent: $count"
    fi
    
    sleep "$interval"
done

cleanup
