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
            docker-compose up --build -d  # Build and start the container in detached mode
            ;;
        build)
            echo "Starting the build process inside Docker container..."
            docker-compose exec w1-dimanet bash -c "gcc -o main main.c -lm && echo 'Build completed.'"
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
            docker-compose exec w1-dimanet bash -c "./dimanet train_data.txt model_save"
            ;;
        run)
            echo "Running the neural network..."
            docker-compose exec w1-dimanet bash -c "./main"  # Run the compiled main.c file inside the container
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
