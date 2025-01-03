#!/bin/bash

IMAGE_NAME="w1-dimanet"

while true; do
    echo -n "> "
    read cmd 

    case $cmd in
        fetch)
            echo "Fetching latest changes from git..."
            git fetch
            ;;
        up)
            echo "Starting Docker containers with docker-compose up..."
            docker-compose up -d  # Start containers in detached mode
            ;;
        build)
            echo "Starting the build process inside Docker container..."

            # Make sure the container is running first
            container_id=$(docker ps -q --filter "name=$IMAGE_NAME")
            if [ -z "$container_id" ]; then
                echo "No running container found. Please start the container first with 'up'."
                exit 1
            fi

            # Copy the source files into the container
            docker cp . "$container_id":/app

            # Build the main.c inside the container
            docker exec "$container_id" bash -c "gcc -o /app/main /app/main.c -lm"

            if [ $? -ne 0 ]; then
                echo "Compilation failed inside the Docker container."
                exit 1
            fi
            ;;
        pull)
            echo "Pulling latest changes from git and docker-compose..."
            git pull
            docker-compose pull
            ;;
        down)
            echo "Stopping Docker containers with docker-compose down..."
            docker-compose down
            ;;
        train)
            echo "Training the neural network..."
            docker exec "$container_id" bash -c "./dimanet train_data.txt model_save"
            ;;
        run)
            echo "Running the neural network..."

            # Ensure the container is running
            if [ -z "$container_id" ]; then
                echo "No running container found. Please start the container first with 'up'."
                exit 1
            fi

            # Run the compiled executable inside the container
            docker exec "$container_id" bash -c "/app/main"
            ;;
        exit)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid command. Available commands: fetch, down, up, pull, build, exit, train, run"
            ;;
    esac
done
