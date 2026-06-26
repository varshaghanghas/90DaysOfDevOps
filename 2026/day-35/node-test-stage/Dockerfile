# --- STAGE 1: Build & Dependency Stage ---
# Practice 1: Use specific tags for base images (node:22.14.0 instead of node:latest)
FROM node:22.14.0 AS builder

WORKDIR /usr/src/app

COPY app.js .


# --- STAGE 2: Lightweight & Secure Production Stage ---
# Practice 2: Use a minimal base image (alpine instead of full ubuntu/debian)
FROM node:22.14.0-alpine

WORKDIR /usr/src/app

# Practice 3: Combine RUN commands to reduce layers (Example if you had system tools)
# RUN apk update && apk add --no-cache curl

# Copy the application from the builder stage
COPY --from=builder /usr/src/app/app.js .

# Practice 4: Don't run as root! Use the built-in 'node' user for security.
USER node

EXPOSE 5000

CMD [ "node", "app.js" ]
