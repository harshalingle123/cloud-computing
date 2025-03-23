#!/bin/bash

THRESHOLD_HIGH=75
THRESHOLD_LOW=75
INSTANCE_NAME="flask-instance"
CHECK_INTERVAL=10
MIGRATED=false

while true; do
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d. -f1)
    echo "Current CPU Usage: $CPU_USAGE%"

    if [ "$CPU_USAGE" -gt "$THRESHOLD_HIGH" ] && [ "$MIGRATED" = false ]; then
        echo "CPU usage exceeded $THRESHOLD_HIGH%, migrating to GCP..."
        bash migrate_to_gcp.sh
        MIGRATED=true
    elif [ "$CPU_USAGE" -lt "$THRESHOLD_LOW" ] && [ "$MIGRATED" = true ]; then
        echo "CPU usage dropped below $THRESHOLD_LOW%, terminating GCP instance..."
        bash terminate_gcp.sh
        MIGRATED=false
    fi

    sleep $CHECK_INTERVAL
done
