FROM node:21-bullseye-slim AS baseImage

RUN apt-get update && apt-get install -y \
    curl \
    telnet \
    netcat \
    dnsutils \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app