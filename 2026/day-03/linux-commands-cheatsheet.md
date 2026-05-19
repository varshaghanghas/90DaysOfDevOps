# Day 3 - Linux Commands Cheat Sheet

## Introduction

Linux commands are essential for DevOps engineers because they help in:

* Managing files and directories
* Monitoring system resources
* Troubleshooting servers
* Debugging applications
* Managing networking issues

This cheat sheet covers commonly used Linux commands for filesystem operations, process management, and networking.

---

# 1. File and Directory Commands

| Command                 | Description                                |
| ----------------------- | ------------------------------------------ |
| `pwd`                   | Show current working directory             |
| `ls`                    | List files and directories                 |
| `ls -lah`               | List detailed files including hidden files |
| `cd directory_name`     | Change directory                           |
| `mkdir folder_name`     | Create a new directory                     |
| `touch file.txt`        | Create a new empty file                    |
| `cp source destination` | Copy files/directories                     |
| `mv source destination` | Move or rename files                       |
| `rm file.txt`           | Delete file                                |
| `rm -rf folder_name`    | Delete folder recursively                  |
| `find . -name file.txt` | Search for files                           |
| `cat file.txt`          | Display file content                       |
| `less file.txt`         | Read large files page by page              |
| `head file.txt`         | Show first 10 lines                        |
| `tail file.txt`         | Show last 10 lines                         |
| `tail -f app.log`       | Monitor logs in real time                  |
| `grep ERROR app.log`    | Search text inside files                   |

---

# 2. Process Management Commands

| Command                   | Description                        |
| ------------------------- | ---------------------------------- |
| `ps aux`                  | Show running processes             |
| `top`                     | Live process monitoring            |
| `htop`                    | Advanced process monitoring        |
| `pgrep nginx`             | Find process ID                    |
| `kill PID`                | Stop process gracefully            |
| `kill -9 PID`             | Force kill process                 |
| `jobs`                    | Show background jobs               |
| `bg`                      | Resume background job              |
| `fg`                      | Bring background job to foreground |
| `systemctl status nginx`  | Check service status               |
| `systemctl restart nginx` | Restart service                    |
| `journalctl -u nginx`     | View service logs                  |

---

# 3. Networking Commands

| Command                 | Description                  |
| ----------------------- | ---------------------------- |
| `ping google.com`       | Check internet connectivity  |
| `curl google.com`       | Send HTTP request            |
| `wget URL`              | Download files               |
| `ip addr`               | Show IP addresses            |
| `hostname -I`           | Display host IP              |
| `ss -tulnp`             | Show open ports and services |
| `netstat -tulnp`        | Network statistics           |
| `dig google.com`        | DNS lookup                   |
| `traceroute google.com` | Trace network route          |

---

# 4. Disk and Memory Commands

| Command              | Description                 |
| -------------------- | --------------------------- |
| `df -h`              | Show disk usage             |
| `du -sh folder_name` | Show folder size            |
| `free -h`            | Show memory usage           |
| `uptime`             | Show system uptime and load |

---

# 5. User Management Commands

| Command        | Description                  |
| -------------- | ---------------------------- |
| `whoami`       | Show current user            |
| `id`           | Show user and group IDs      |
| `sudo command` | Run command as administrator |
| `passwd`       | Change password              |

---

# 6. Useful Troubleshooting Workflow

## Step 1 - Check System Usage

```bash
top
```

## Step 2 - Find High CPU Processes

```bash
ps aux --sort=-%cpu | head
```

## Step 3 - Check Open Ports

```bash
ss -tulnp
```

## Step 4 - Check Logs

```bash
tail -f app.log
```

## Step 5 - Kill Problematic Process

```bash
kill PID
```

---

# Key Learnings

* Linux commands are essential for DevOps troubleshooting.
* Process monitoring helps identify system issues.
* Networking commands help debug connectivity problems.
* Log monitoring is critical for production systems.
* Troubleshooting is a step-by-step investigation process.

---

# Conclusion

Practicing Linux commands daily improves speed and confidence while working with servers and cloud environments. Strong Linux fundamentals are necessary for DevOps, Cloud, Docker, and Kubernetes.
