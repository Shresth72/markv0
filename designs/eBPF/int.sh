#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <interface> <packet_count>"
    exit 1
fi

INTERFACE="$1"
PACKET_COUNT="$2"

if ! [[ "$PACKET_COUNT" =~ ^[0-9]+$ ]]; then
    echo "Error: Packet count must be a positive integer."
    exit 1
fi

echo "Sending $PACKET_COUNT packets continuously on interface $INTERFACE..."

while true; do
    # Send 300 ICMP packets using ping in flood mode
    sudo ping -I "$INTERFACE" -f -c "$PACKET_COUNT" -s 120 8.8.8.8  # Sending to a known address (Google)

    if [[ $? -eq 0 ]]; then
        echo "Successfully sent $PACKET_COUNT packets."
    else
        echo "Error sending packets on interface $INTERFACE."
        exit 1
    fi

    sleep 0.5
done
