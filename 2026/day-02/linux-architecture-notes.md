# Day 2 - Linux Fundamentals & Architecture

**Date:** May 17, 2026  
**Phase:** 1

---

# Introduction

## Intro to:
- DevOps
- Cloud
- SRE (Site Reliability Engineering)

### Why are we learning this?
- Better opportunities
- High-paying jobs
- Industry demand

---

# Linux Fundamentals

## What is an Operating System?

An Operating System (OS) is a set of programs that manages:
- Hardware
- Software
- System resources

Examples:
- macOS
- Windows
- Linux
- Android
- iOS

Linux and macOS are based on UNIX concepts.

---

# Linux Distributions (Flavors)

Linux comes in different versions/distributions:

- Ubuntu
- Fedora
- CentOS
- Red Hat
- Kali Linux
- Amazon Linux

### Important Distros
| Distribution | Usage |
|---|---|
| Ubuntu | Local practice |
| Red Hat Enterprise Linux | Enterprise/Production |
| Amazon Linux | AWS/Cloud |

---

# Linux History

- Linux is free and open source.
- Created in 1991.
- Anyone can:
  - use it
  - modify it
  - contribute to it

### Industry Usage
- More than 90% of servers use Linux.

---

# Why Linux for DevOps?

DevOps Engineers must understand:
- Operating Systems
- Servers
- Processes
- Networking

Linux is important because:
- Most servers run Linux
- Multi-user support
- High security
- Strong command-line tools

---

# Linux Features

## Security
Linux provides strong security features.

## Multi-user
Multiple users can access and use the same server.

Example:
- Switching users
- Managing permissions

---

# Linux Architecture

## How Linux Works

```text
Application Layer
       ↓
Shell
       ↓
Kernel
       ↓
Hardware
```

---

# Components of Linux

## 1. Kernel

- Heart/core of Linux OS
- Communicates with hardware
- Written mainly in C language

### Responsibilities
- Memory management
- Process management
- Device management

---

## 2. Shell

Shell acts as an interface between:
- User
- Kernel

It accepts human-readable commands.

### Types of Shells
- Bash (Bourne Again Shell)
- sh
- zsh

---

## 3. Applications

Examples:
- Docker
- Kubernetes
- VS Code
- IDEs

---

# RAM vs CPU

## RAM
- Stores temporary data
- Example:
  - Browser tabs
  - Running applications

## CPU
- Executes instructions/processes

---

# System Startup Process

## Main Components

1. Hardware
2. Software
3. Firmware

### Firmware
Example:
- BIOS

BIOS helps start the system.

---

# Linux Boot Process

```text
Power ON Computer
        ↓
BIOS (Basic Input Output System)
        ↓
Bootloader
        ↓
Kernel Starts
        ↓
systemd (PID 1)
        ↓
Services/Processes Start
```

---

# Bootloader

- Loads Linux kernel into memory
- Starts the operating system

---

# systemd

- First process started in Linux
- Process ID = 1 (PID 1)

### Important Points
- Everything in Linux is a process.
- Many background services are daemons.

Examples:
- dockerd
- sshd

These run as background processes.

---

# Shell & Terminal

## Terminal
- An application/program

## Shell
- Accessed through terminal
- Executes commands

---

# Linux File System Hierarchy

## Important Concepts

- Everything in Linux starts from `/`
- Everything is either:
  - file
  - directory
  - process

---

# Important Directories

## Root Directory

```bash
/
```

Called the root directory.

---

## /bin

Contains binary executable commands.

Examples:
- ls
- cat
- pwd

---

## ~

```bash
~
```

Represents the home directory.

Example:
```bash
cd ~
```

---

# Root Directory Structure

## /etc

Stores:
- configuration files

Example:
```bash
/etc/fstab
```

Used for filesystem table and automount configuration.

---

## /sbin/init or systemd

- First process started by kernel

---

# Monitoring Commands

## htop
Interactive system monitoring tool.

## top
Shows real-time system resource usage.

---

# Linux Commands Practice (In Sequence)

## 1. Check Current Directory

```bash
pwd
```

Shows:
- Present Working Directory

---

## 2. Change Directory

```bash
cd ~
```

Moves to home directory.

Example:
```bash
cd /etc
```

---

## 3. List Files & Directories

```bash
ls
```

### Long Listing

```bash
ls -l
```

### Show Hidden Files

```bash
ls -la
```

### File Types in `ls`

| Symbol | Meaning |
|---|---|
| d | directory |
| l | link |
| - | regular file |

---

## 4. Create Directory

```bash
mkdir demo
```

### Create Nested Directories

```bash
mkdir -p demo/test
```

`-p` creates parent directories if they don't exist.

---

## 5. Move into Directory

```bash
cd demo
```

---

## 6. Create File

```bash
touch hello.txt
```

Creates empty file.

---

## 7. Write into File

```bash
echo "Hello Linux" > hello.txt
```

---

## 8. Read File Content

```bash
cat hello.txt
```

### Example

```bash
cat /etc/os-release
```

Shows Linux distribution information.

---

## 9. Edit File using Vim

```bash
vim hello.txt
```

### Insert Mode

Press:
```text
i
```

### Save & Exit

```text
:wq
```

---

## 10. Read First Lines of File

```bash
head hello.txt
```

### Read First N Lines

```bash
head -n 2 hello.txt
```

---

## 11. Read Last Lines of File

```bash
tail hello.txt
```

### Read Last N Lines

```bash
tail -n 2 hello.txt
```

---

## 12. Check Disk Space

```bash
df -h
```

Shows disk space usage.

---

## 13. Check RAM Usage

```bash
free -h
```

Shows RAM/memory usage.

---

## 14. Check Date & Time

```bash
date
```

---

## 15. Check System Uptime

```bash
uptime
```

Shows how long system has been running.

---

## 16. Count Lines in File

```bash
wc -l hello.txt
```

Or:

```bash
cat hello.txt | wc -l
```

---

## 17. Run Command in Background

```bash
command &
```

`&` sends process to background.

---

## 18. Run Process using nohup

```bash
nohup command &
```

### Meaning
- "No Hang Up"
- Process keeps running after terminal closes.

---

# Docker Practice

## Run Ubuntu Container

```bash
docker run -itd ubuntu
```

### Meaning of Flags

| Flag | Meaning |
|---|---|
| -i | interactive |
| -t | terminal |
| -d | detached/background |

---

## Access Running Container

```bash
docker exec -it <container-id> bash
```

Opens bash shell inside container.

---