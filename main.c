#include "dimanet.h"
#include <stdio.h>
#include <stdlib.h>

#define INPUT_SIZE 2
#define HIDDEN_LAYERS 1
#define HIDDEN_NEURONS 3
#define OUTPUT_SIZE 1

// Simple activation functions (we'll use the provided ones)
double activation_function(const dimanet *ann, double input) {
    return dimanet_act_sigmoid(ann, input);
}

int main() {
    // Create a new neural network with 2 inputs, 1 hidden layer with 3 neurons, and 1 output.
    dimanet *ann = dimanet_init(INPUT_SIZE, HIDDEN_LAYERS, HIDDEN_NEURONS, OUTPUT_SIZE);

    // Randomize weights
    dimanet_randomize(ann);

    // Example input and expected output for training
    double input[] = {0.1, 0.9}; // Example input for the neural network
    double output[] = {0.0}; // Expected output after training

    // Run the network
    double const *result = dimanet_run(ann, input);
    printf("Output before training: %f\n", result[0]);

    // Train the network
    double learning_rate = 0.1;
    dimanet_train(ann, input, output, learning_rate);

    // Run the network again after training
    result = dimanet_run(ann, input);
    printf("Output after training: %f\n", result[0]);

    // Free the memory used by the neural network
    dimanet_free(ann);

    return 0;
}
