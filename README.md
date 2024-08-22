# Technical-tasks

# System Resource Monitoring Script

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

## License

Feel free to modify and use it according to your needs.
