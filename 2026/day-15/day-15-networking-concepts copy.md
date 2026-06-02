# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

## Task 1: DNS – How Names Become IPs

### What happens when you type google.com in a browser?

When you type `google.com` in a browser, the system first checks its local DNS cache. If the address is not found, it queries a DNS resolver, which contacts DNS servers to find the corresponding IP address. Once the IP address is returned, the browser establishes a connection to that server and loads the website.

### DNS Record Types

| Record Type | Purpose |
|-------------|---------|
| A | Maps a domain name to an IPv4 address |
| AAAA | Maps a domain name to an IPv6 address |
| CNAME | Creates an alias for another domain |
| MX | Specifies mail servers for a domain |
| NS | Specifies authoritative name servers |

### Command

```bash
dig google.com
```

### Output

```text
;; ANSWER SECTION:
google.com.     300     IN      A       142.250.193.14
```

**A Record:** `142.250.193.14`

**TTL:** `300`

---

## Task 2: IP Addressing

### What is an IPv4 Address?

An IPv4 address is a unique 32-bit identifier assigned to devices on a network. It is written in dotted decimal notation.

Example:

```text
192.168.1.10
```

### Public vs Private IP

| Type | Example | Description |
|--------|---------|-------------|
| Public IP | 8.8.8.8 | Accessible over the internet |
| Private IP | 192.168.1.10 | Used within local networks |

### Private IP Ranges

```text
10.0.0.0 – 10.255.255.255
172.16.0.0 – 172.31.255.255
192.168.0.0 – 192.168.255.255
```

### Command

```bash
ip addr show
```

### Example Output

```text
inet 192.168.1.101/24 brd 192.168.1.255 scope global dynamic
```

**Private IP Identified:** `192.168.1.101`

---

## Task 3: CIDR & Subnetting

### What does /24 mean?

`/24` means the first 24 bits represent the network portion of the address, leaving 8 bits for host addresses.

### Usable Hosts

| CIDR | Total IPs | Usable Hosts |
|------|-----------|--------------|
| /24 | 256 | 254 |
| /16 | 65,536 | 65,534 |
| /28 | 16 | 14 |

### Why Do We Subnet?

Subnetting divides a larger network into smaller logical networks. This improves security, network performance, and IP address management while reducing broadcast traffic.

### CIDR Table

| CIDR | Subnet Mask | Total IPs | Usable Hosts |
|------|-------------|-----------|--------------|
| /24 | 255.255.255.0 | 256 | 254 |
| /16 | 255.255.0.0 | 65,536 | 65,534 |
| /28 | 255.255.255.240 | 16 | 14 |

---

## Task 4: Ports – The Doors to Services

### What is a Port?

A port is a communication endpoint that allows different applications and services to exchange data over a network.

### Common Ports

| Port | Service |
|------|---------|
| 22 | SSH |
| 80 | HTTP |
| 443 | HTTPS |
| 53 | DNS |
| 3306 | MySQL |
| 6379 | Redis |
| 27017 | MongoDB |

### Command

```bash
ss -tulpn
```

### Example Output

```text
tcp LISTEN 0 128 0.0.0.0:22
tcp LISTEN 0 511 0.0.0.0:80
```

### Port Mapping

| Port | Service |
|------|---------|
| 22 | SSH |
| 80 | HTTP |

---

## Task 5: Putting It Together

### You run curl http://myapp.com:8080 — what networking concepts are involved?

1. DNS resolves `myapp.com` to an IP address.
2. TCP establishes a connection to the destination host.
3. Port `8080` identifies the specific application/service.
4. Routing ensures packets reach the destination server.
5. The server responds with the requested data.

### Your app can't reach a database at 10.0.1.50:3306 — what would you check first?

- Verify network connectivity using `ping` or `telnet`.
- Confirm the database service is running.
- Check whether port `3306` is open and listening.
- Review firewall and security group rules.
- Validate application configuration (IP, port, credentials).

---

## What I Learned

1. DNS translates human-readable domain names into IP addresses.
2. IPv4 addresses identify devices on a network.
3. CIDR notation defines network size and host capacity.
4. Subnetting helps organize and secure networks.
5. Ports allow multiple services to operate on a single IP address.
6. DNS, IP addressing, routing, and ports work together to enable network communication.