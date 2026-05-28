# Day 5 - Linux Troubleshooting Drill: CPU, Memory, and Logs

## Objective

Practice Linux troubleshooting inside an Ubuntu Docker container by simulating:
- High CPU usage
- Memory pressure
- Log analysis
- Disk usage issues

---

# Step 1 - Start Ubuntu Container

Run the Ubuntu container:

```bash
docker run -it ubuntu bash
docker exec -it container_id bash
```

---

# Step 2 - Install Required Tools

Inside the container:

```bash
apt update && apt install -y \
procps \
htop \
sysstat \
stress \
curl \
vim \
less \
psmisc \
iproute2 \
net-tools
```

---

# Step 3 - CPU Troubleshooting Practice

## Create CPU Load

```bash
stress --cpu 2
```

This creates artificial CPU load.

---

## Monitor CPU Usage

### Using top

```bash
top
```

### Using htop

```bash
htop
```

---

## Find High CPU Processes

```bash
ps aux --sort=-%cpu | head
```

---

## Check System Load

```bash
uptime
```

---

## Kill Problematic Process

Find PID:

```bash
pgrep stress
```

Kill process:

```bash
kill -9 <PID>
```

---

# Step 4 - Memory Troubleshooting Practice

## Create Memory Pressure

```bash
stress --vm 1 --vm-bytes 512M
```

---

## Check Memory Usage

```bash
free -h
```

---

## Find Top Memory Consumers

```bash
ps aux --sort=-%mem | head
```

---

## Monitor Memory in Real Time

```bash
vmstat 1
```

---

## Monitor Container Resources from Host

Run on host machine:

```bash
docker stats
```

---

# Step 5 - Log Troubleshooting Practice

## Create Log Directory

```bash
mkdir /logs
```

---

## Generate Fake Logs

```bash
while true; do
  echo "$(date) ERROR Database connection failed" >> /logs/app.log
  sleep 2
done
```

Open another shell:

```bash
docker exec -it ubuntu-lab bash
```

---

## View Live Logs

```bash
tail -f /logs/app.log
```

---

## Search Errors

```bash
grep ERROR /logs/app.log
```

---

## Count Errors

```bash
grep -c ERROR /logs/app.log
```

---

## View Last 20 Lines

```bash
tail -20 /logs/app.log
```

---

# Step 6 - Disk Troubleshooting Practice

## Create Large File

```bash
fallocate -l 1G bigfile.img
```

---

## Check Disk Usage

```bash
df -h
```

---

## Check Directory Sizes

```bash
du -sh /*
```

---

## Find Large Files

```bash
find / -type f -size +100M 2>/dev/null
```

---

# Step 7 - Incident Simulation

## Incident 1 - High CPU

```bash
stress --cpu 4
```

Tasks:
- Identify issue
- Find process
- Kill process
- Verify CPU recovery

---

## Incident 2 - Memory Exhaustion

```bash
stress --vm 2 --vm-bytes 1G
```

Tasks:
- Observe memory usage
- Find offending process
- Stop process

---

## Incident 3 - Log Explosion

```bash
while true; do
  echo "$(date) FATAL Payment service crashed" >> /logs/error.log
done
```

Tasks:
- Detect disk growth
- Analyze logs
- Clean log file safely

Solution:

```bash
truncate -s 0 /logs/error.log
```

---

# Key Linux Commands Learned

| Command | Purpose |
|---|---|
| top | Monitor CPU and processes |
| htop | Interactive process viewer |
| ps | View running processes |
| free | Check memory usage |
| vmstat | System performance statistics |
| grep | Search logs |
| tail | View recent logs |
| df | Disk space usage |
| du | Directory size usage |
| find | Search files |
| kill | Stop processes |

---

# Key Learning

Troubleshooting is not about memorizing commands.

It is about:
1. Observing symptoms
2. Identifying bottlenecks
3. Verifying assumptions
4. Fixing issues safely
5. Preventing recurrence

---

# Conclusion

This exercise helped practice:
- CPU troubleshooting
- Memory debugging
- Log analysis
- Disk cleanup
- Linux process management

Using Docker containers is a safe and efficient way to build real-world troubleshooting skills.