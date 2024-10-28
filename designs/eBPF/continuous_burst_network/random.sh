#!/bin/bash

TARGET_IP="192.168.1.1"  # Change to your target IP
TARGET_PORT=1234          # Change to your target port
SOURCE_IP=$(ip -o -f inet addr show eth0 | awk '{print $4}' | cut -d/ -f1)  # Get the IP address of eth0

while true; do
    # Random number of packets to send in a burst (e.g., between 100 and 500)
    burst_size=$((RANDOM % 401 + 100))
    echo "Starting a burst of $burst_size packets to $TARGET_IP:$TARGET_PORT"
    
    # Create a function to send packets
    send_packets() {
        for ((i=0; i<burst_size; i++)); do
            packet="Packet $i from $(hostname)"
            echo "$packet" | nc -u -w1 -s "$SOURCE_IP" "$TARGET_IP" "$TARGET_PORT" &
        done
        wait  # Wait for all background processes to complete
    }

    # Call the function to send packets
    send_packets
    
    # Random wait time between bursts (e.g., between 1 and 5 seconds)
    sleep_time=$((RANDOM % 5 + 1))
    echo "Burst complete. Waiting $sleep_time seconds before the next burst."
    sleep "$sleep_time"
done
