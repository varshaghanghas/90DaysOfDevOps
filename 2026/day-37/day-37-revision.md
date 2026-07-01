# Day 37 – Docker Revision & Cheat Sheet


## Self-Assessment Checklist
Mark yourself honestly — **can do**, **shaky**, or **haven't done**:

- [x] Run a container from Docker Hub (interactive + detached)
- [x] List, stop, remove containers and images
- [x] Explain image layers and how caching works
- [x] Write a Dockerfile from scratch with FROM, RUN, COPY, WORKDIR, CMD
- [x] Explain CMD vs ENTRYPOINT
- [x] Build and tag a custom image
- [x] Create and use named volumes
- [x] Use bind mounts
- [x] Create custom networks and connect containers
- [x] Write a docker-compose.yml for a multi-container app
- [x] Use environment variables and .env files in Compose
- [x] Write a multi-stage Dockerfile
- [x] Push an image to Docker Hub
- [x] Use healthchecks and depends_on

---

## Docker Basics

## Image vs Container

| Image | Container |
|--------|-----------|
| Read-only template | Running instance of an image |
| Used to create containers | Executes the application |
| Immutable | Can be started, stopped, and removed |

Example:

```bash
docker pull nginx
docker run nginx
```

---

## Common Docker Commands

### Run a Container

```bash
docker run nginx
```

Run in detached mode:

```bash
docker run -d nginx
```

Run interactively:

```bash
docker run -it ubuntu bash
```

---

### View Containers

Running containers:

```bash
docker ps
```

All containers:

```bash
docker ps -a
```

---

### Stop and Remove

Stop:

```bash
docker stop <container_name>
```

Remove:

```bash
docker rm <container_name>
```

View logs:

```bash
docker logs <container_name>
```

Execute inside a running container:

```bash
docker exec -it <container_name> bash
```

---

## Port Mapping

```bash
docker run -p 8080:80 nginx
```

Format:

```
Host Port : Container Port
```

Example:

```
8080 → Host
80   → Container
```

---

## Docker Images

List images:

```bash
docker images
```

Build image:

```bash
docker build -t myapp:1.0 .
```

Tag image:

```bash
docker tag myapp:1.0 username/myapp:1.0
```

Push image:

```bash
docker push username/myapp:1.0
```

Delete image:

```bash
docker rmi image_name
```

---

## Dockerfile

Example:

```dockerfile
FROM node:18

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
```

### Common Instructions

| Instruction | Purpose |
|-------------|---------|
| FROM | Base image |
| WORKDIR | Working directory |
| COPY | Copy files |
| RUN | Execute command during build |
| EXPOSE | Document application port |
| CMD | Default startup command |
| ENTRYPOINT | Main executable |

---

## CMD vs ENTRYPOINT

### CMD

```dockerfile
CMD ["npm", "start"]
```

Provides a default command.

---

### ENTRYPOINT

```dockerfile
ENTRYPOINT ["python"]
CMD ["app.py"]
```

Always runs the executable while allowing arguments.

---

## COPY vs ADD

Use **COPY** for normal file copying.

```dockerfile
COPY . .
```

Use **ADD** only when you need:

- Archive extraction
- URL downloads

---

## Docker Layers

Every Dockerfile instruction creates a new layer.

Good Dockerfile order:

```dockerfile
COPY package*.json ./
RUN npm install

COPY . .
```

This allows Docker to reuse cached layers.

---

## Docker Volumes

Create volume:

```bash
docker volume create mydata
```

List volumes:

```bash
docker volume ls
```

Inspect volume:

```bash
docker volume inspect mydata
```

Use volume:

```bash
docker run -v mydata:/data nginx
```

Delete volume:

```bash
docker volume rm mydata
```

---

## Bind Mount

```bash
docker run -v $(pwd):/app node:18
```

Useful during development because changes on the host are immediately visible inside the container.

---

## Docker Networks

Create network:

```bash
docker network create mynetwork
```

List networks:

```bash
docker network ls
```

Inspect:

```bash
docker network inspect mynetwork
```

Run container:

```bash
docker run -d --name app --network mynetwork nginx
```

Containers on the same custom network communicate using container names.

Example:

```
app → db
```

---

## Docker Compose

Example:

```yaml
services:
  app:
    build: .
    ports:
      - "3000:3000"
    depends_on:
      - db

  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: password
```

Commands:

Start:

```bash
docker compose up
```

Detached:

```bash
docker compose up -d
```

Stop:

```bash
docker compose down
```

Remove volumes:

```bash
docker compose down -v
```

Logs:

```bash
docker compose logs
```

Rebuild:

```bash
docker compose build
```

---

## Environment Variables

Example:

```yaml
environment:
  NODE_ENV: production
```

Using `.env`

```env
POSTGRES_PASSWORD=password
APP_PORT=3000
```

---

## Multi-Stage Build

```dockerfile
FROM node:18 AS build

WORKDIR /app

COPY . .

RUN npm install

RUN npm run build

FROM nginx

COPY --from=build /app/dist /usr/share/nginx/html
```

Benefits:

- Smaller images
- Faster deployment
- Better security

---

## Health Checks

Example:

```yaml
healthcheck:
  test: ["CMD-SHELL", "pg_isready -U postgres"]
  interval: 10s
  timeout: 5s
  retries: 5
```

Health checks verify whether the container is actually ready.

---

## Cleanup Commands

Disk usage:

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

Remove unused volumes:

```bash
docker volume prune
```

Remove unused networks:

```bash
docker network prune
```

Remove everything unused:

```bash
docker system prune
```

Aggressive cleanup:

```bash
docker system prune -a
```

---

## Quick Revision

### Image vs Container

- Image → Blueprint
- Container → Running application

---

### Port Mapping

```
Host:Container
8080:80
```

---

### Volume

Stores persistent data outside the container.

---

### Bind Mount

Shares a host directory with the container.

---

### Docker Compose

Runs multiple containers using a single YAML file.

---

### Multi-stage Build

Creates smaller production images.

---

### Docker Network

Allows containers to communicate using container names.

---

### COPY vs ADD

Prefer **COPY** unless ADD's extra features are required.

---

### CMD vs ENTRYPOINT

- CMD → Default command
- ENTRYPOINT → Fixed executable

---

## Important Commands Cheat Sheet

```bash
docker images
docker ps
docker ps -a
docker run
docker stop
docker rm
docker logs
docker exec
docker build
docker push
docker pull
docker volume ls
docker network ls
docker compose up
docker compose down
docker system df
docker system prune
```

---

## Day 37 Summary

- Revised Docker fundamentals
- Reviewed Dockerfile instructions
- Practiced Docker Compose
- Revised Volumes & Networks
- Learned image optimization with Multi-stage Builds
- Created a Docker Cheat Sheet for quick reference