#!/bin/bash

LOG_FILE="/var/log/git-server-monitor.log"

check_service() {
    service=$1
    if systemctl is-active --quiet "$service"; then
        echo "$(date): $service is running" >> "$LOG_FILE"
        return 0
    else
        echo "$(date): $service is down!" >> "$LOG_FILE"
        systemctl restart "$service"
        return 1
    fi
}

check_disk_space() {
    usage=$(df /var/git | tail -1 | awk '{print $5}' | sed 's/%//')
    if [ "$usage" -gt 80 ]; then
        echo "$(date): Disk usage high: ${usage}%" >> "$LOG_FILE"
    fi
}

echo "$(date): Starting monitoring check" >> "$LOG_FILE"

check_service nginx
check_service fcgiwrap
check_disk_space

echo "$(date): Monitoring check complete" >> "$LOG_FILE"
