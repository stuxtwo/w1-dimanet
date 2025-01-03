FROM debian:bullseye-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

RUN chmod +x controller.sh
