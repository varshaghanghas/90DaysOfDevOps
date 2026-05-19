# Day 04 - Linux Processes, Logs & Troubleshooting

## Introduction

Today I practiced Linux process management, log monitoring, and basic troubleshooting commands. These are essential DevOps skills used to monitor and debug servers.

---

# 1. Process Management Commands

## Check Running Processes

```bash id="h38f0u"
ps aux
```

Purpose:
Displays all currently running processes in the system.

---

## Find Specific Process

```bash id="1q7gzu"
ps aux | grep ssh
```

Purpose:
Searches for a specific running process.

---

## Live Process Monitoring

```bash id="h5qcrf"
top
```

Purpose:
Shows real-time CPU and memory usage.

Press:

```bash id="klgf0h"
q
```

to exit.

---

## Kill a Process

```bash id="3zc1tx"
kill PID
```

Purpose:
Stops a running process gracefully.

---

## Force Kill a Process

```bash id="0yvzys"
kill -9 PID
```

Purpose:
Forcefully terminates a process.

---

# 2. Log Monitoring Commands

## View System Logs

```bash id="cw6tht"
tail -n 50 /var/log/syslog
```

Purpose:
Displays the latest system logs.

---

## Monitor Logs in Real Time

```bash id="rzr4r2"
tail -f /var/log/syslog
```

Purpose:
Continuously monitors live log updates.

Stop monitoring using:

```bash id="9dg0iw"
CTRL + C
```

---

## Search Errors in Logs

```bash id="85mcln"
grep ERROR /var/log/syslog
```

Purpose:
Searches for error messages inside logs.

---

# 3. Networking and Troubleshooting Commands

## Check IP Address

```bash id="x4w6gt"
ip addr
```

Purpose:
Displays network interface and IP address information.

---

## Test Connectivity

```bash id="a2s9c4"
ping google.com
```

Purpose:
Checks internet/network connectivity.

---

## Check Open Ports

```bash id="u0nqeo"
ss -tulnp
```

Purpose:
Displays listening ports and network services.

---

# 4. Mini Troubleshooting Practice

## Scenario

Investigating high CPU usage in the system.

---

## Step 1 - Monitor CPU Usage

```bash id="4e26eh"
top
```

Observation:
Identified a high CPU consuming process.

---

## Step 2 - Find Process Details

```bash id="f8y1mj"
ps aux --sort=-%cpu | head
```

Observation:
Displayed top CPU-consuming processes.

---

## Step 3 - Kill Problematic Process

```bash id="yyf5y2"
kill -9 PID
```

Observation:
Stopped the problematic process successfully.

---

# 5. Key Learnings

* Learned how Linux processes work
* Practiced monitoring CPU and memory usage
* Understood how to inspect logs for troubleshooting
* Learned basic networking inspection commands
* Practiced identifying and stopping problematic processes

---

# Conclusion

Linux troubleshooting involves:

1. Observing system behavior
2. Inspecting processes and logs
3. Identifying issues
4. Taking corrective actions

These skills are important for DevOps, Cloud, Docker, and Kubernetes environments.
