# Day 12 – Breather & Revision (Days 01–11)

## Day 1 – Introduction to DevOps & Cloud Engineering

### What is DevOps and Cloud Engineering?

According to me, DevOps means **Dev + Ops**, which stands for **Development + Operations**.  
It is a practice where developers and operations teams work together to build, deploy, and manage applications efficiently.

### Why am I learning DevOps and Cloud?

I am learning DevOps and Cloud for better career opportunities and higher-paying jobs.  
Nowadays, most companies are moving their applications and services to the cloud, so DevOps engineers are highly in demand.

I am currently working as a web developer, and I want to switch my career to become a DevOps Engineer.

### Skills I want to build

- CI/CD Pipelines
- Kubernetes
- Linux
- Docker
- AWS Cloud

---

## Day 2 – Linux Fundamentals & Architecture

### Linux

Linux is an Operating System (OS).  
An OS is a set of programs that manages hardware, software, and system resources.

Examples of operating systems:
- Windows
- macOS
- Linux
- Android
- iOS

Linux and macOS are based on UNIX concepts.

- UNIX is paid and proprietary
- Linux is open source

### Popular Linux Distributions

- Ubuntu (most popular and widely used)
- Fedora
- Red Hat
- Amazon Linux

### Linux Architecture

Linux architecture has three main components:

1. **Application Layer**
2. **Shell**
3. **Kernel**

- The **Shell** acts as an interface between the user and the kernel.
- The **Kernel** directly communicates with hardware and system resources.

---

## Day 3 – Linux Commands Practice

### Process Management Commands

- `ps` or `ps aux` → Show running processes
- `top` or `htop` → Live process monitoring
- `grep` or `pgrep` → Find processes
- `kill PID` → Kill a process
- `kill -9 PID` → Force kill a process
- `jobs` → Show background jobs
- `head` and `tail` → Show top and bottom lines of files

### Networking Commands

- `ping`
- `curl`
- `netstat`
- `dig` → DNS lookup

---

## Day 4 – Linux Processes, Logs & Troubleshooting

### Useful Commands

```bash
ps aux
top
htop
````

If `ip addr` does not work, install `iproute2`:

```bash
apt-get update
apt-get install -y iproute2
```

---

## Day 5 – Linux Troubleshooting Drill: CPU, Memory & Logs

Practiced troubleshooting system performance issues related to:

* CPU usage
* Memory usage
* Logs analysis

---

## Day 6 – Linux Fundamentals: Read & Write Text Files

### File Commands

* `touch` → Create a file
* `echo` → Add content to a file

Example:

```bash
echo "Linux is important for DevOps" > notes.txt
```

* `vim` → Create and edit files
* `nano` → Edit files
* `head` and `tail` → Display top and bottom lines in a file
* `pwd` → Check current directory
* `mkdir` → Create directory
* `ls` → List files and directories

---

## Day 7 – Linux File System Hierarchy & Scenario-Based Practice

### Install Nginx

```bash
apt update
apt install nginx -y
```

### Check Nginx Status

```bash
systemctl status nginx
```

### Read Important Files

```bash
cat /etc/passwd
cat /etc/hostname
```

---

## Day 8 – Cloud Deployment using AWS EC2 & Nginx

I created an AWS EC2 instance and installed Nginx on it.

### Connect to EC2 via SSH

```bash
ssh -i your-key.pem ubuntu@public_IP
```

### Verify Nginx Installation

```bash
curl localhost
```

---

## Day 9 – Linux User & Group Management Challenge

### User Management

```bash
useradd -m username
```

Creates a user with a home directory.

```bash
passwd username
```

Set password for the user.

```bash
cat /etc/passwd
```

Verify users.

### Group Management

```bash
groupadd groupname
```

Create a group.

```bash
cat /etc/group
```

Verify groups.

### Permission & Ownership Commands

```bash
chmod 775 file_path
```

Change file permissions.

```bash
chgrp groupname file_path
```

Change group ownership.

```bash
su username
```

Switch user.

```bash
exit
```

Exit user session.

---

## Day 10 – File Permissions & File Operations Challenge

### Commands Practiced

```bash
ls -l
```

List files and directories.

```bash
head -n 5 /etc/passwd
```

Show top 5 lines.

```bash
tail -n 5 /etc/passwd
```

Show last 5 lines.

### Permission Types

* `r` → Read (4)
* `w` → Write (2)
* `x` → Execute (1)

---

## Day 11 – File Ownership Challenge (`chown` & `chgrp`)

### Change File Owner

```bash
chown username file_path
```

### Change File Group

```bash
chgrp newgroup filename
```

### Change Owner & Group Together

```bash
chown owner:newgroup filename
```

### File Permission Format Example

```bash
-rw-r--r-- 1 owner group size date filename
```

