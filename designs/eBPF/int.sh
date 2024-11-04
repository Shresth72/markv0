#!/bin/bash

# Check if an interface argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <interface>"
    exit 1
fi

# Assign the first argument to the INTERFACE variable
INTERFACE="$1"

# Number of packets to send in each burst
PACKET_COUNT=500

# Infinite loop to keep sending packets
echo "Sending $PACKET_COUNT packets continuously on interface $INTERFACE..."

while true; do
    # Send 300 ICMP packets using ping in flood mode
    sudo ping -I "$INTERFACE" -f -c "$PACKET_COUNT" -s 120 8.8.8.8  # Sending to a known address (Google)

    # Check if ping executed successfully
    if [[ $? -eq 0 ]]; then
        echo "Successfully sent $PACKET_COUNT packets."
    else
        echo "Error sending packets on interface $INTERFACE."
        exit 1
    fi

    # Wait for half a second before the next burst
    sleep 0.5
done
