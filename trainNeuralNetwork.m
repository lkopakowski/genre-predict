
lambda_array = [1 3 10];
hidden_layer_size_array = [38 100 200];
for i = 1: length(lambda_array);
for j = 1: length(hidden_layer_size_array);
hidden_layer_size = hidden_layer_size_array(j);
lamda = lambda_array(i);
X_subset = X(1:10000, :);
Y_subset = Y(1:10000, :);

input_layer_size = size(X_subset, 2);

output_layer_size = size(Y_subset, 2);
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, output_layer_size);

unrolled_params = [initial_Theta1(:) ; initial_Theta2(:)];

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   output_layer_size, X_subset, Y_subset, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)

options = optimset('MaxIter', 50);

[nn_params, cost] = fmincg(costFunction, unrolled_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 output_layer_size, (hidden_layer_size + 1));

X_val = X(10001:size(X, 1), :);
Y_val = Y(10001:size(X,1), :);
fprintf('\nTraining Set Accuracy for lambda: %d and hidden layer size: %d',lamda, hidden_layer_size)
[h2 pred] = predict(Theta1, Theta2, X_subset, Y_subset);
fprintf('\nCR Set Accuracy:')

[h2 pred] = predict(Theta1, Theta2, X_val, Y_val);
fflush(stdout);
end
end
