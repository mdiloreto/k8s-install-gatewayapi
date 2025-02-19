#!/usr/bin/env bash

# Replace this with your IP address
IP="34.86.197.4"

# Define some ANSI colors
GREEN="\033[0;32m"
BLUE="\033[0;34m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
RESET="\033[0m"  # Reset color

# Counters
v1_count=0
v2_count=0
total_count=0

# Trap SIGINT (Ctrl+C) to calculate and display final stats before exiting
trap ctrl_c INT

ctrl_c() {
  echo
  echo -e "${RED}Exiting...${RESET}"

  if [ $total_count -gt 0 ]; then
    # Calculate percentages
    v1_percent=$(awk "BEGIN { printf \"%.2f\", ($v1_count / $total_count) * 100 }")
    v2_percent=$(awk "BEGIN { printf \"%.2f\", ($v2_count / $total_count) * 100 }")

    echo -e "${YELLOW}===== Traffic Split Report =====${RESET}"
    echo "  v1 responses: $v1_count (${v1_percent}%)"
    echo "  v2 responses: $v2_count (${v2_percent}%)"
    echo "  Total requests: $total_count"
    echo -e "${YELLOW}================================${RESET}"
  else
    echo "No requests were made."
  fi

  exit 0
}

echo -e "${GREEN}Hitting http://${IP} repeatedly. Press CTRL+C to stop and see results.${RESET}"
echo

# Infinite loop for sending requests
while true; do
  timestamp=$(date +%H:%M:%S)
  
  # Grab the line containing 'Server' from the response, strip HTML tags
  raw_response=$(curl -s "http://${IP}/" \
    | grep "Server" \
    | sed 's/<[^>]*>//g; s/&nbsp;/ /g')

  # Check if raw_response contains "v2"
  if echo "$raw_response" | grep -qi "v2"; then
    version="v2"
    v2_count=$((v2_count + 1))
    # Color "Detected: v2" in green
    echo -e "[$timestamp] Response: $raw_response -> Detected: ${GREEN}v2${RESET}"
  else
    version="v1"
    v1_count=$((v1_count + 1))
    # Color "Detected: v1" in blue
    echo -e "[$timestamp] Response: $raw_response -> Detected: ${BLUE}v1${RESET}"
  fi

  total_count=$((total_count + 1))

  # Small delay
  sleep 1
done
