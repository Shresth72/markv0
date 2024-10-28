#!/bin/bash

TARGET_IP="192.168.1.1"  # Change to your target IP
TARGET_PORT=1234          # Change to your target port
SOURCE_IP=$(ip -o -f inet addr show eth0 | awk '{print $4}' | cut -d/ -f1)  # Get the IP address of eth0

BURST_SIZE=300            # Fixed number of packets to send in each burst
WAIT_TIME=1               # Fixed wait time between bursts (in seconds)

while true; do
    echo "Starting a burst of $BURST_SIZE packets to $TARGET_IP:$TARGET_PORT"
    
    # Create a function to send packets
    send_packets() {
        for ((i=0; i<BURST_SIZE; i++)); do
            packet="Packet $i from $(hostname)"
            echo "$packet" | nc -u -w1 -s "$SOURCE_IP" "$TARGET_IP" "$TARGET_PORT" &
        done
        wait  # Wait for all background processes to complete
    }

    # Call the function to send packets
    send_packets
    
    echo "Burst complete. Waiting $WAIT_TIME seconds before the next burst."
    sleep "$WAIT_TIME"  # Wait for the fixed time before the next burst
done
