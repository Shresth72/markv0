#!/bin/bash

TARGET_IP="192.168.1.1"  # Change to your target IP
TARGET_PORT=1234          # Change to your target port
SOURCE_IP=$(ip -o -f inet addr show cni0 | awk '{print $4}' | cut -d/ -f1)  # Get the IP address of eth0

while true; do
    # Random number of packets to send in a burst (e.g., between 5 and 20)
    burst_size=$((RANDOM % 16 + 5))
    
    for ((i=0; i<burst_size; i++)); do
        echo "Packet $i from $(hostname)" | nc -u -w1 -s "$SOURCE_IP" "$TARGET_IP" "$TARGET_PORT"
    done
    
    # Random wait time between bursts (e.g., between 1 and 5 seconds)
    sleep_time=$((RANDOM % 5 + 1))
    sleep "$sleep_time"
done
