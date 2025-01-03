# Makefile to compile the project

# Compiler and Flags
CC = gcc
CFLAGS = -I./dimanet -lm
SRC = main.c dimanet/*.c
OUT = main

# Default target
all: $(OUT)

# Build the executable
$(OUT): $(SRC)
	$(CC) -o $(OUT) $(SRC) $(CFLAGS)

# Clean up
clean:
	rm -f $(OUT)
