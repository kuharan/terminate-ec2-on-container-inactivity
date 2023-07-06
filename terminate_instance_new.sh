#!/bin/bash

# Check if any Docker container is running
containers_running=$(docker ps --format '{{.State}}' | grep -c "running")

if [ $containers_running -gt 0 ]; then
  echo "At least one Docker container is running. Exiting..."
  exit 0
fi

# Get system uptime in minutes
uptime_minutes=$(awk '{print $1}' /proc/uptime | awk -F. '{print $1}')

# Convert uptime to hours
uptime_hours=$((uptime_minutes / 60))

if [ $uptime_hours -ge 2 ]; then
  echo "System uptime is more than 2 hours. Shutting down..."
  sudo shutdown -h now
else
  echo "System uptime is less than 2 hours. No action required."
fi
