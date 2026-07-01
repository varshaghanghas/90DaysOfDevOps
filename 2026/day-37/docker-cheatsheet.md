# Docker Cheat Sheet

A quick reference for commonly used Docker commands and concepts.

---

## Docker Images

Pull an image:

```bash
docker pull <image_name>
```

List images:

```bash
docker images
```

Build an image:

```bash
docker build -t <image_name>:<tag> .
```

Tag an image:

```bash
docker tag <image_name>:<tag> <username>/<image_name>:<tag>
```

Push an image:

```bash
docker push <username>/<image_name>:<tag>
```

Remove an image:

```bash
docker rmi <image_name>
```

---

## Docker Containers

Run a container:

```bash
docker run <image_name>
```

Run in detached mode:

```bash
docker run -d <image_name>
```

Run interactively:

```bash
docker run -it <image_name> bash
```

Run with a custom name:

```bash
docker run --name my-container <image_name>
```

Run with port mapping:

```bash
docker run -p 8080:80 <image_name>
```

List running containers:

```bash
docker ps
```

List all containers:

```bash
docker ps -a
```

Stop a container:

```bash
docker stop <container_name>
```

Start a stopped container:

```bash
docker start <container_name>
```

Restart a container:

```bash
docker restart <container_name>
```

Remove a container:

```bash
docker rm <container_name>
```

Force remove a running container:

```bash
docker rm -f <container_name>
```

---

## Docker Logs & Exec

View logs:

```bash
docker logs <container_name>
```

Follow logs:

```bash
docker logs -f <container_name>
```

Execute commands inside a running container:

```bash
docker exec -it <container_name> bash
```

Inspect container details:

```bash
docker inspect <container_name>
```

---

## Docker Volumes

Create a volume:

```bash
docker volume create my-volume
```

List volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect my-volume
```

Use a volume:

```bash
docker run -v my-volume:/data <image_name>
```

Delete a volume:

```bash
docker volume rm my-volume
```

Remove unused volumes:

```bash
docker volume prune
```

---

## Bind Mounts

Mount current directory:

```bash
docker run -v $(pwd):/app <image_name>
```

---

## Docker Networks

List networks:

```bash
docker network ls
```

Create a network:

```bash
docker network create my-network
```

Inspect a network:

```bash
docker network inspect my-network
```

Connect a container to a network:

```bash
docker run --network my-network <image_name>
```

Remove a network:

```bash
docker network rm my-network
```

---

## Docker Compose

Start services:

```bash
docker compose up
```

Start in background:

```bash
docker compose up -d
```

Stop services:

```bash
docker compose down
```

Stop and remove volumes:

```bash
docker compose down -v
```

View logs:

```bash
docker compose logs
```

List services:

```bash
docker compose ps
```

Rebuild services:

```bash
docker compose build
```

Restart services:

```bash
docker compose restart
```

---

## Docker System Cleanup

View disk usage:

```bash
docker system df
```

Remove stopped containers:

```bash
docker container prune
```

Remove unused images:

```bash
docker image prune
```

Remove unused networks:

```bash
docker network prune
```

Remove unused volumes:

```bash
docker volume prune
```

Remove all unused Docker resources:

```bash
docker system prune
```

Remove everything including unused images:

```bash
docker system prune -a
```

---

## Dockerfile Instructions

| Instruction | Description |
|------------|-------------|
| `FROM` | Base image |
| `WORKDIR` | Set working directory |
| `COPY` | Copy files from host |
| `ADD` | Copy files, extract archives, download URLs |
| `RUN` | Execute commands during build |
| `ENV` | Set environment variables |
| `EXPOSE` | Document application port |
| `CMD` | Default startup command |
| `ENTRYPOINT` | Main executable |
| `LABEL` | Add image metadata |

---

## Common Port Mapping

```text
Host:Container

8080:80
3000:3000
5000:5000
5432:5432
6379:6379
```

---

## Important Concepts

### Image
- Blueprint/template for creating containers.

### Container
- Running instance of an image.

### Volume
- Persistent storage that survives container removal.

### Bind Mount
- Shares a host directory with a container.

### Network
- Enables communication between containers.

### Docker Compose
- Runs multiple containers using a single YAML configuration.

### Multi-Stage Build
- Produces smaller, optimized production images.

### CMD vs ENTRYPOINT

| CMD | ENTRYPOINT |
|------|------------|
| Default command | Fixed executable |
| Can be overridden | Runs every time |

### COPY vs ADD

- Use **COPY** for normal file copying.
- Use **ADD** only when archive extraction or URL support is needed.

---

## Most Frequently Used Commands

```bash
docker pull nginx
docker images
docker ps
docker ps -a
docker run -d nginx
docker stop <container>
docker start <container>
docker restart <container>
docker rm <container>
docker exec -it <container> bash
docker logs <container>
docker build -t myapp .
docker push username/myapp
docker compose up -d
docker compose down
docker system df
docker system prune -a
```