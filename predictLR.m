function [output predictions performance] = predictLR(Theta, X, Y, lambda, threshold_array)
%PREDICT Predict the label of an input given a trained logistic regression model
%   p = PREDICT(Theta, X, Y, lambda) outputs the predicted label of X given the
%   trained weights of a logistic regression model Theta.
% output - The output values corresponding to the genre indices. 1 if it's a genre match and 0 if not
% precitions - The raw output probabilities that a book is of the genre at that index.
% performance - The performance of the model given various parameters.

% Useful values
m = size(X, 1);
num_labels = size(Y, 2);

X = [ones(m, 1) X];

output = sigmoid(X * Theta');
                 
performance = zeros(length(threshold_array) ,5);
for i = 1 : length(threshold_array)
    threshold = threshold_array(i);
    predictions = output > threshold;
    predictedPositives = sum(predictions(:));
    actualPositives = sum(Y(:));

    fflush(stdout);
    truePositives = sum(and(predictions, Y)(:));
    %correctNonPredictions = sum(and(!predictions, !Y)(:));
    %falsePredictions = sum(xor(predictions, Y)(:));

    precision = truePositives / predictedPositives;
    recall = truePositives / actualPositives;
    fMeasure = 2 * (precision * recall) / (precision + recall);
    fprintf("\nThreshold: %d, Precision: %d, Recall: %d, F Measure: %d\n", threshold, precision, recall, fMeasure);
    fflush(stdout);
    performance(i, 1) = lambda;
    performance(i, 2) = threshold;
    performance(i, 3) = precision;
    performance(i, 4) = recall;
    performance(i, 5) =  fMeasure;
end
             
% =========================================================================


end
