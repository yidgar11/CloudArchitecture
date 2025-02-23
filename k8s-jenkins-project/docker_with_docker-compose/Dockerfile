# Use the official Docker image as the base
FROM docker:latest

# Set environment variables to avoid Python warnings and improve pip performance
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    DOCKER_CONFIG=/usr/local/lib/docker

# Install dependencies
RUN apk add --no-cache \
    bind-tools \
    curl \
    iputils \
    net-tools \
    python3 \
    py3-pip

# Install Docker Compose plugin
RUN mkdir -p $DOCKER_CONFIG/cli-plugins && \
    curl -SL https://github.com/docker/compose/releases/download/v2.33.0/docker-compose-linux-x86_64 \
    -o $DOCKER_CONFIG/cli-plugins/docker-compose && \
    chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Verify installation of Docker Compose
RUN docker compose version