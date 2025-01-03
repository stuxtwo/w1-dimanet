#!/bin/bash

# Function for displaying the prompt and handling commands
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
            gcc -o main main.c -lm  # Assuming the code is in main.c and you need the math library (-lm)
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
            # Assuming 'train_data.txt' and 'model_save' exist or are passed in
            ./dimanet train_data.txt model_save
            ;;
        run)
            echo "Running the neural network..."
            # Assuming user input is processed and passed to the neural network
            ./main
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
