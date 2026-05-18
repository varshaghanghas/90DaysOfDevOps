# Day 02 – Linux Architecture, Processes, and systemd

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

# Linux Commands Practiced

## pwd

```bash
pwd
```

Shows:
- Present Working Directory

---

## cd

```bash
cd
```

Changes directory.

---

## cat

```bash
cat filename.txt
```

Displays file content.

### Example

```bash
cat /etc/os-release
```

Shows Linux distribution information.

---

## echo

```bash
echo "hello"
```

Prints text/output.

---

## ls

```bash
ls
```

Lists files/directories.

### File Types in ls

| Symbol | Meaning |
|---|---|
| d | directory |
| l | link |
| - | regular file |

---

## df -h

```bash
df -h
```

Shows disk space usage.

---

## free -h

```bash
free -h
```

Shows RAM/memory usage.

---

## date

```bash
date
```

Displays current date/time.

---

## uptime

```bash
uptime
```

Shows system running time.

---

# mkdir Command

## Create Directory

```bash
mkdir demo
```

## Create Parent Directories

```bash
mkdir -p demo/test
```

`-p` creates parent directories if they don't exist.

---

# touch Command

```bash
touch hello.txt
```

Creates empty file.

---

# Writing into File

```bash
echo "text" > hello.txt
```

Writes text into file.

---

# Vim Editor

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

# head Command

## First 10 lines

```bash
head hello.txt
```

## First N lines

```bash
head -n 2 hello.txt
```

---

# tail Command

## Last 10 lines

```bash
tail hello.txt
```

## Last N lines

```bash
tail -n 2 hello.txt
```

---

# Docker Practice

## Run Ubuntu Container

```bash
docker run -itd ubuntu
```

### Meaning
| Flag | Meaning |
|---|---|
| -i | interactive |
| -t | terminal |
| -d | detached/background |

---

# Access Running Container

```bash
docker exec -it <container-id> bash
```

Opens bash shell inside container.

---

# nohup Command

```bash
nohup command &
```

Runs process in background.

### Meaning
- "No Hang Up"
- Process keeps running even after terminal closes.

---

# wc Command

## Count Lines

```bash
wc -l filename.txt
```

Or:

```bash
cat filename.txt | wc -l
```

---

# Run Command in Background

```bash
command &
```

`&` sends process to background.

---