# Day 15 - IP Addressing, DNS, Security and AWS VPC

## Objective

Understand how devices are addressed on the Internet and how AWS networking works.

---

# IP Address

An IP Address uniquely identifies a device on a network.

Example:

```text
192.168.1.10
```

---

# Internet Protocol (IP)

Defines rules for:

- Addressing
- Routing
- Packet Delivery

---

# IPv4

IPv4 uses a 32-bit address.

Example:

```text
192.168.1.10
```

Total possible addresses:

```text
4.3 Billion Addresses
```

---

# IPv6

IPv6 uses a 128-bit address.
Provides virtually unlimited addresses.

Example:

```text
2001:db8::1
```

Benefits:

- Massive address space
- Better scalability


---

# Subnet

A subnet is a logical subdivision of a network.

Benefits:

- Better organization
- Better security
- Efficient IP allocation

---

# CIDR

Classless Inter-Domain Routing.

Example:

```text
192.168.1.0/24
```

Formula:

```text
Number of IPs = 2^(32 - n)
```

Where:

```text
n = CIDR value
```

Examples:

| CIDR | IP Count |
|--------|----------|
| /24 | 256 |
| /16 | 65,536 |
| /8 | 16,777,216 |

---

# Network Address

First IP in a subnet.

Example:

```text
192.168.1.0
```

---

# Broadcast Address

Last IP in a subnet.

Example:

```text
192.168.1.255
```

---

# DNS (Domain Name System)

DNS converts domain names into IP addresses.

Example:

```text
google.com
     ↓
142.x.x.x
```
### How DNS Works
![How DNS Works ](./img/How-DNS-works.png)

- You enter a website address (e.g., google.com) in your browser
- The browser sends a DNS request to find the website's IP address.
- The DNS Resolver checks its cache; if not found, it queries the Root DNS Server.
- The Root DNS Server directs it to the TLD Server (e.g., .com).
- The TLD Server points to the Authoritative DNS Server.
- The Authoritative DNS Server returns the website's IP address.
- The DNS Resolver sends the IP address back to your browser.
- Your browser connects to the website's server using that IP address and loads the page.
- The result is cached for faster access next time

---

## DNS Resolution Flow

DNS (Domain Name System) acts like the phonebook of the Internet. It translates human-friendly domain names (e.g., google.com) into machine-readable IP addresses (e.g., 142.250.x.x). This entire process typically takes only a few milliseconds, making web browsing seamless.

```text
User
   ↓
Browser
   ↓
Local Cache
   ↓
Recursive DNS Resolver
   ↓
Root DNS Server
   ↓
TLD DNS Server (.com)
   ↓
Authoritative DNS Server
   ↓
IP Address Returned
   ↓
Website Server
   ↓
Webpage Loads
```

---

# Common DNS Components

## Root DNS

Knows TLD locations.

---

## TLD Server

Examples:

- .com
- .org
- .in

---

## Authoritative DNS

Stores actual DNS records.

---

# Internet Security

## Firewall

Controls network traffic.

---

## Ingress

Incoming traffic.

```text
Internet → Server
```

---

## Egress

Outgoing traffic.

```text
Server → Internet
```

---

# TLS

Transport Layer Security.

Provides:

- Encryption
- Authentication

HTTPS uses TLS.

SSL is outdated.

---

# Common Ports

| Service | Port |
|----------|------|
| HTTP | 80 |
| HTTPS | 443 |
| SSH | 22 |
| SMTP | 25 |

---

# Port

Virtual communication endpoint.

Think:

```text
IP Address = Building
Port = Room Number
```

Example:

```text
10.0.0.5:443
```

---

# AWS VPC

Virtual Private Cloud.

A private network inside AWS.

---

# Public Subnet

Accessible from the Internet.

Examples:

- Web Servers
- Load Balancers

---

# Private Subnet

Not directly accessible from the Internet.

Examples:

- Databases
- Internal Services

---

# Internet Gateway

Provides Internet access to public subnets.

---

# NAT Gateway

Allows private resources to access the Internet without exposing them publicly.

```text
Private EC2
     ↓
NAT Gateway
     ↓
Internet
```

---

# Route Table

Controls how traffic moves inside a VPC.

Contains routes for:

- Internet Gateway
- NAT Gateway
- Internal Networks

---

# System Design

System Design is the process of planning a system before implementation.

Goals:

- Scalability
- Reliability
- Security
- Availability
- Cost Optimization

---

## Typical Architecture

```text
React Frontend
      ↓
Backend API
      ↓
PostgreSQL
      ↓
Redis Cache
```

![System Design Architetcure](./img/SystemDesign.png)

---

## Databases

### PostgreSQL

Best for:

- Structured Data
- Transactions

### MongoDB

Best for:

- Flexible Schema
- Unstructured Data

---

## JWT

Used for:

- Authentication
- Authorization
- User Sessions

---

## Microservices

Application split into multiple independent services.

Examples:

- Auth Service
- User Service
- Notification Service
- AI Service

Benefits:

- Independent deployment
- Better scaling
- Easier maintenance

---

## Load Balancer

Distributes traffic across multiple servers.

```text
Users
  ↓
Load Balancer
  ↓
Server 1
Server 2
Server 3
```

---

## Scaling

### Vertical Scaling

```text
2 CPU → 8 CPU
```

### Horizontal Scaling

```text
1 Server → 10 Servers
```

Preferred for large systems.

---

## Kubernetes

Responsibilities:

- Deployment
- Auto Scaling
- Self Healing
- Service Discovery

---

## Monitoring

### Prometheus

Collects metrics.

Examples:

- CPU
- Memory
- Requests

### Grafana

Visualizes metrics using dashboards.

---

## Redis

In-memory datastore used for:

- Caching
- Sessions
- Fast lookups

---

# Key Takeaways

- IPv4 is limited; IPv6 solves address exhaustion
- CIDR defines subnet size
- DNS converts domains to IPs
- TLS secures communication
- Firewalls control ingress and egress traffic
- Public subnets are internet-facing
- Private subnets are protected
- NAT Gateway provides outbound internet access
- Route tables control traffic flow