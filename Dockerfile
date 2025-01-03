FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    gcc \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY dimanet/dimanet.c dimanet/dimanet.h ./

RUN gcc -o dimanet dimanet.c -lm

ENTRYPOINT ["/bin/bash", "controller.sh"]
