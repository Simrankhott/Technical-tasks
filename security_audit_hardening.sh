#!/bin/bash

# Function to display top 5 CPU-consuming applications
top_applications() {
    echo "Top 5 CPU-Consuming Applications:"
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
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

# Function to display CPU usage
display_cpu_usage() {
    echo "=== CPU Usage ==="
    top -bn1 | grep "Cpu(s)" | sed "s/Cpu(s):/CPU Usage:/"
    echo ""
}

# Function to display memory usage
display_memory_usage() {
    echo "=== Memory Usage ==="
    free -h
    echo ""
}

# Function to display disk usage
display_disk_usage() {
    echo "=== Disk Usage ==="
    df -h
    echo ""
}

# Function to display network statistics
display_network_stats() {
    echo "=== Network Statistics ==="
    ifstat 1 1
    echo ""
}

# Function to display system load
display_system_load() {
    echo "=== System Load ==="
    uptime
    echo ""
}

# Function to display top processes by CPU and memory
display_top_processes() {
    echo "=== Top Processes by CPU ==="
    ps aux --sort=-%cpu | head -n 6
    echo ""
    echo "=== Top Processes by Memory ==="
    ps aux --sort=-%mem | head -n 6
    echo ""
}

# Function to display active services
display_services() {
    echo "=== Active Services ==="
    systemctl list-units --type=service --state=running
    echo ""
}

# Function to audit users and groups
display_user_group_audit() {
    echo "=== User and Group Audit ==="
    echo "Users:"
    cut -d: -f1 /etc/passwd
    echo ""
    echo "Groups:"
    cut -d: -f1 /etc/group
    echo ""
}

# Function to audit file and directory permissions
display_file_permissions() {
    echo "=== File and Directory Permissions ==="
    echo "World-writable files and directories:"
    find / -perm -0002 -type f -o -type d 2>/dev/null | head -n 5
    echo ""
    echo "SUID/SGID files:"
    find / -perm -4000 -o -perm -2000 2>/dev/null | head -n 5
    echo ""
}

# Function to audit running services and open ports
display_service_audit() {
    echo "=== Service Audit ==="
    echo "Running services:"
    systemctl list-units --type=service --state=running
    echo ""
    echo "Listening ports:"
    netstat -tuln | head -n 10
    echo ""
}

# Function to check firewall status
display_firewall_status() {
    echo "=== Firewall Status ==="
    if command -v ufw &> /dev/null; then
        echo "UFW Status:"
        ufw status verbose
    else
        echo "UFW is not installed"
    fi
    echo ""
}

# Function to display IP and network configuration
display_ip_network() {
    echo "=== IP and Network Configuration ==="
    ip a
    echo ""
    echo "IP Forwarding:"
    sysctl net.ipv4.ip_forward
    echo ""
}

# Function to list available security updates
display_security_updates() {
    echo "=== Security Updates ==="
    
    # Update package list quietly
    sudo apt update -qq > /dev/null
    
    # List upgradable packages and handle potential issues
    apt list --upgradable 2>/dev/null | awk -F' ' '/upgradable from/ {print $1, $2, $3}' | head -n 5
    
    echo ""
}

# Function to display recent suspicious log entries
display_log_monitoring() {
    echo "=== Log Monitoring ==="
    echo "Recent SSH logins:"
    grep 'sshd' /var/log/auth.log | tail -n 10
    echo ""
    echo "Recent kernel messages:"
    dmesg | tail -n 10
    echo ""
}

# Function to display server hardening settings
display_server_hardening() {
    echo "=== Server Hardening ==="
    echo "SSH Configuration:"
    grep -E '^PermitRootLogin|^PasswordAuthentication' /etc/ssh/sshd_config
    echo ""
    echo "IPv6 Configuration:"
    sysctl net.ipv6.conf.all.disable_ipv6
    echo ""
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --cpu) display_cpu_usage ;;
        --memory) display_memory_usage ;;
        --disk) display_disk_usage ;;
        --network) display_network_stats ;;
        --load) display_system_load ;;
        --process) display_top_processes ;;
        --service) display_services ;;
        --user) display_user_group_audit ;;
        --file) display_file_permissions ;;
        --service-audit) display_service_audit ;;
        --firewall) display_firewall_status ;;
        --ip) display_ip_network ;;
        --updates) display_security_updates ;;
        --log) display_log_monitoring ;;
        --hardening) display_server_hardening ;;
        --all) 
            display_cpu_usage
            display_memory_usage
            display_disk_usage
            display_network_stats
            display_system_load
            display_top_processes
            display_services
            display_user_group_audit
            display_file_permissions
            display_service_audit
            display_firewall_status
            display_ip_network
            display_security_updates
            display_log_monitoring
            display_server_hardening
            ;;
        *) echo "Invalid option: $1"; exit 1 ;;
    esac
    shift
done
