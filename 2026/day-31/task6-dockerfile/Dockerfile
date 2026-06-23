# base image
FROM nginx:alpine

WORKDIR /usr/share/nginx/html

# 1. Run static setup steps first (these rarely change)
RUN echo "Installing dependencies..." && sleep 3

# 2. Copy code files last (these change constantly)
COPY index.html .
