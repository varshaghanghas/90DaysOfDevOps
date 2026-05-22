# Day-07 Linux Filesystem Practice

## Objective

Learn Linux filesystem structure and practice real-world troubleshooting.

---

# Linux Filesystem Structure

```text
/
├── etc      -> configuration files
├── var      -> logs and variable data
├── home     -> user home directories
├── tmp      -> temporary files
├── usr      -> binaries and libraries
├── bin      -> basic commands
├── sbin     -> system binaries
├── proc     -> process information
├── dev      -> devices
```

---

# Run Ubuntu Container Using Docker

## Start Ubuntu Bash Shell

```bash
docker run -it ubuntu bash
```

This command:

- `docker run` → creates and starts container
- `-it` → interactive terminal
- `ubuntu` → Docker image name
- `bash` → opens bash shell inside container

---

# Verify You Are Inside Container

```bash
ls /
pwd
cat /etc/os-release
```

## Why sudo Does Not Work Inside Docker Container

Error:

```text
sudo: command not found
```

Reason:
Docker Ubuntu containers usually run as the `root` user by default and do not include the `sudo` package.

Use commands without `sudo`.

Example:

```bash
apt update
apt install nginx -y
```

Check current user:

```bash
whoami
```

---

# Commands Practiced

## Navigate Filesystem

```bash
pwd
ls /
cd /etc
cd /var/log
cd /home
```

---

# Read Important Files

```bash
cat /etc/passwd
cat /etc/hostname
```

---

# Install NGINX

```bash
apt update
apt install nginx -y
```

---

# Check NGINX Status

```bash
systemctl status nginx
```

---

# NGINX Important Paths

## Config Location

```bash
/etc/nginx/
```

## Log Location

```bash
/var/log/nginx/
```

---

# Watch Logs

```bash
tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log
```

---

# Test NGINX Config

```bash
nginx -t
```

---

# Restart NGINX

```bash
systemctl restart nginx
```

---

# Disk Usage Commands

## Check Disk Space

```bash
df -h
```

## Find Large Directories

```bash
du -sh /* 2>/dev/null
```

## Find Large Files

```bash
find / -type f -size +500M 2>/dev/null
```

---

# User Management Practice

```bash
adduser devopsuser
ls /home
```

---

# Screenshot Section

## Add Images

Example:

```md
![NGINX Status](images/nginx-status.png)

![Filesystem Structure](images/filesystem.png)
```

Create images folder:

```bash
mkdir images
```

Place screenshots inside the `images/` directory.

---

# What I Learned

- Linux filesystem hierarchy
- NGINX installation
- Service troubleshooting
- Log inspection
- Disk usage analysis
- Basic Linux administration

---

# Practice Questions

1. Where are nginx logs stored?
2. Which directory stores configs?
3. How do you check disk usage?
4. How do you restart a service?
5. How do you test nginx configuration?
