#!/bin/bash

# Function to display top 10 CPU-consuming applications
top_applications() {
    echo "Top 10 CPU-Consuming Applications:"
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 11
    echo
}

# Function to display network stats
network_stats() {
    echo "Network Stats:"
    echo "Concurrent Connections: $(ss -tun | wc -l)"
    
    # Measure network traffic in MB
    rx_bytes=$(cat /sys/class/net/eth0/statistics/rx_bytes 2>/dev/null || echo 0)
    tx_bytes=$(cat /sys/class/net/eth0/statistics/tx_bytes 2>/dev/null || echo 0)
    
    sleep 1
    
    rx_bytes_new=$(cat /sys/class/net/eth0/statistics/rx_bytes 2>/dev/null || echo 0)
    tx_bytes_new=$(cat /sys/class/net/eth0/statistics/tx_bytes 2>/dev/null || echo 0)
    
    rx_mb=$(( (rx_bytes_new - rx_bytes) / 1024 / 1024 ))
    tx_mb=$(( (tx_bytes_new - tx_bytes) / 1024 / 1024 ))
    
    echo "Network Traffic: In: ${rx_mb} MB, Out: ${tx_mb} MB"
    echo
}

# Function to display disk usage
disk_usage() {
    echo "Disk Usage:"
    df -h | awk '
        NR==1 {print; next}
        {
            printf "%-20s %-10s %-10s %-10s %-5s %s\n", $1, $2, $3, $4, $5, $6
            if (substr($5, 1, length($5)-1) > 80) {
                print "Warning: " $1 " is using more than 80% of disk space."
            }
        }'
    echo
}

# Function to display system load
system_load() {
    echo "System Load:"
    uptime
    echo
}

# Function to display memory usage
memory_usage() {
    echo "Memory Usage:"
    free -h
    echo
}

# Function to display active processes and top 3 by CPU and memory
process_monitoring() {
    echo "Active Processes: $(ps -e | wc -l)"
    echo "Top 3 Processes by CPU:"
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 4
    echo "Top 3 Processes by Memory:"
    ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 4
    echo
}

# Function to check essential services
service_monitoring() {
    echo "Service Monitoring:"
    for service in sshd nginx apache2; do
        if systemctl is-active --quiet $service; then
            echo "$service is running"
        else
            echo "$service is not running"
        fi
    done
    echo
}

# Handle command-line arguments
case "$1" in
    -apps) top_applications ;;
    -network) network_stats ;;
    -disk) disk_usage ;;
    -load) system_load ;;
    -memory) memory_usage ;;
    -processes) process_monitoring ;;
    -services) service_monitoring ;;
    -all)
        top_applications
        network_stats
        disk_usage
        system_load
        memory_usage
        process_monitoring
        service_monitoring
        ;;
    *)
        echo "Usage: $0 {-apps|-network|-disk|-load|-memory|-processes|-services|-all}"
        ;;
esac
