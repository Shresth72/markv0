#!/bin/bash

HOST="127.0.0.1"
PORT=5000      
PACKET_SIZE=512
HIGH_RATE=200 
LOW_RATE=20     
DURATION_HIGH=10

PACKET_DATA=$(head -c $PACKET_SIZE < /dev/zero)  # Generate dummy data

function send_packets {
  local rate=$1
  local duration=$2
  local interval=$(echo "1/$rate" | bc -l)

  end_time=$(($(date +%s) + duration))
  while [ $(date +%s) -lt $end_time ]; do
    echo "$PACKET_DATA" | nc -q 0 $HOST $PORT &
    sleep $interval
  done
}

# High-rate traffic
echo "Sending $HIGH_RATE packets per second for $DURATION_HIGH seconds..."
send_packets $HIGH_RATE $DURATION_HIGH

# Low-rate traffic
echo "Reducing to $LOW_RATE packets per second..."
while true; do
  send_packets $LOW_RATE 1
done

