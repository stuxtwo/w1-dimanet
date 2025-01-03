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
            docker-compose up
            ;;
        build)
            echo "Starting Docker containers with docker-compose up --build..."
            if [[ -f "main.c" ]]; then
                gcc -o main main.c -lm
                    if [[ $? -ne 0 ]]; then
                    echo "Compilation failed."
                exit 1
                fi
            else
                echo "main.c not found!"
                exit 1
            fi
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
            ./dimanet train_data.txt model_save
            ;;
        run)
            echo "Running the neural network..."
            echo "Running the project..."
            if [[ -f "./main" ]]; then
                ./main  # Run the compiled executable
            else
                echo "Executable not found. Make sure the build step was successful."
                exit 1
            fi
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
