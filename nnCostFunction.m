function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, Y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network

    Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                     hidden_layer_size, (input_layer_size + 1));

    Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                     num_labels, (hidden_layer_size + 1));

    % Setup some useful variables
    m = size(X, 1);
             
    % You need to return the following variables correctly 
    J = 0;
    Theta1_grad = zeros(size(Theta1));
    Theta2_grad = zeros(size(Theta2));
    X = [ones(m, 1), X];

    a2 = sigmoid(X * Theta1');
    a2PlusOnes = [ones(size(a2, 1),1), a2];
    a3 = sigmoid(a2PlusOnes * Theta2');

    jTemp =  (1 / m * (-Y .* log(a3) - (1 - Y) .* log (1 - a3)));
    J = sum(jTemp(:));
    Theta1Temp = Theta1(:, 2:size(Theta1, 2));
    Theta2Temp = Theta2(:, 2:size(Theta2, 2));
    J = J + lambda / (2 * m) * (sum((Theta1Temp.^2)(:)) + sum((Theta2Temp.^2)(:)));

    for i = 1 : m
        a1 = X(i, :);
        a2 = [1, sigmoid(a1 * Theta1')];
        a3 = sigmoid(a2 * Theta2');
        delta3 = a3 - Y(i, :);
        delta2 = (delta3 * Theta2)(2:end) .* sigmoidGradient(a1 * Theta1');
        Theta1_grad = Theta1_grad + (a1' * delta2)';
        Theta2_grad = Theta2_grad + (a2' * delta3)';
     end

     Theta1_grad = Theta1_grad / m + lambda / m * [zeros(size(Theta1, 1), 1) Theta1(:, 2:end)];
     Theta2_grad = Theta2_grad / m + lambda / m * [zeros(size(Theta2, 1), 1) Theta2(:, 2:end)];

     % Unroll gradients
     grad = [Theta1_grad(:) ; Theta2_grad(:)];

end
