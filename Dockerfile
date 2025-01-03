FROM debian:bullseye-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    gcc \
    make \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN chmod +x controller.sh && ./controller.sh build

CMD ["./controller.sh"]
