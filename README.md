# Technical-tasks

# Task 1: System Resource Monitoring Script

## Overview

This script monitors various system resources and presents them in a dashboard format. It can display information about CPU usage, network statistics, disk usage, system load, memory usage, active processes, and the status of essential services. The script allows users to view specific parts of the dashboard using command-line options or display everything with a single command.

## Features

- **Top 10 CPU-Consuming Applications:** Lists the top 10 applications using the most CPU resources.
- **Network Monitoring:** Shows the number of concurrent connections and network traffic (in and out).
- **Disk Usage:** Displays disk space usage and warns if any partition is using more than 80% of the disk space.
- **System Load:** Provides the current system load and uptime.
- **Memory Usage:** Shows total, used, and free memory, as well as swap usage.
- **Process Monitoring:** Displays the number of active processes and the top 3 processes by CPU and memory usage.
- **Service Monitoring:** Checks and reports the status of essential services like `sshd`, `nginx`, and `apache2`.

## Usage

Save the script as `monitor.sh` and make it executable:

```bash
chmod +x monitor.sh
```

Run the script with the desired option:

- `-apps`: Display the top 10 CPU-consuming applications.
- `-network`: Display network statistics.
- `-disk`: Display disk usage.
- `-load`: Display system load.
- `-memory`: Display memory usage.
- `-processes`: Display active processes and top 3 by CPU and memory usage.
- `-services`: Display the status of essential services.
- `-all`: Display all the information.

### Example

To display all the information:

```bash
./monitor.sh -all
```

## Notes

- Ensure the script is run with appropriate permissions to access system statistics.
- Network statistics are based on the `eth0` network interface. Adjust the script if your network interface is different.
- Disk usage warnings are based on the 80% threshold.

## Troubleshooting

If you encounter any issues, ensure that:

- You have the necessary permissions to run the script.
- The required commands (`ps`, `ss`, `df`, `uptime`, `free`, `systemctl`) are available on your system.


Here's a README file for your `security_audit_hardening.sh` script:

---

# TASK 2: Security Audit and Hardening Script

## Overview

This script is designed to perform a comprehensive security audit and hardening check on a Linux server. It covers various aspects including system resource usage, network configuration, security updates, and server hardening practices. The script provides detailed information and allows you to run specific checks based on command-line arguments.

## Features

- **CPU Usage**: Displays top CPU-consuming applications and overall CPU usage.
- **Memory Usage**: Shows memory usage statistics.
- **Disk Usage**: Provides information on disk space utilization.
- **Network Statistics**: Displays network traffic and connection stats.
- **System Load**: Shows system load averages.
- **Top Processes**: Lists top processes by CPU and memory usage.
- **Active Services**: Lists all running services.
- **User and Group Audit**: Shows current users and groups.
- **File and Directory Permissions**: Audits file permissions, including world-writable and SUID/SGID files.
- **Service Audit**: Lists running services and open ports.
- **Firewall Status**: Displays the status of the Uncomplicated Firewall (UFW).
- **IP and Network Configuration**: Shows IP addresses, network interfaces, and IP forwarding settings.
- **Security Updates**: Lists available security updates.
- **Log Monitoring**: Provides recent SSH logins and kernel messages.
- **Server Hardening**: Checks SSH configuration and IPv6 settings.

## Usage

To use the script, run it with one or more of the following command-line arguments:

```bash
./security_audit_hardening.sh [OPTIONS]
```

### Options

- `--cpu`: Display top CPU-consuming applications and CPU usage.
- `--memory`: Display memory usage.
- `--disk`: Display disk usage.
- `--network`: Display network statistics.
- `--load`: Display system load.
- `--process`: Display top processes by CPU and memory.
- `--service`: Display active services.
- `--user`: Audit users and groups.
- `--file`: Audit file and directory permissions.
- `--service-audit`: Audit running services and open ports.
- `--firewall`: Display firewall status.
- `--ip`: Display IP and network configuration.
- `--updates`: List available security updates.
- `--log`: Display recent log entries.
- `--hardening`: Display server hardening settings.
- `--all`: Run all checks.

### Example

To run all checks:

```bash
./security_audit_hardening.sh --all
```

## Requirements

- `ps`, `ss`, `ifstat`, `top`, `free`, `df`, `netstat`, `grep`, `awk`, `sysctl`, `cut`, `find`, `dmesg`, `systemctl`, `apt`, and `ufw` must be installed and available in the system PATH.
- The script requires `sudo` privileges for updating package lists and some system commands.

## Notes

- The `apt` command may produce warnings about CLI stability. These can generally be ignored unless specific issues are encountered.
- The script outputs may vary depending on the system configuration and installed packages.

## License

Feel free to modify and use it according to your needs.
