function [h2 predictions] = predictNN(Theta1, Theta2, X, Y)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

h1 = sigmoid([ones(m, 1) X] * Theta1');
h2 = sigmoid([ones(m, 1) h1] * Theta2');
predictions = h2 > .5;
predictedPositives = sum(predictions(:));
actualPositives = sum(Y(:))
truePositives = sum(and(predictions, Y)(:));
correctNonPredictions = sum(and(!predictions, !Y)(:));
falsePredictions = sum(xor(predictions, Y)(:));

fprintf("\nCorrect Predictions %d:", truePositives);
fprintf("\nCorrect Non Predictions %d:", correctNonPredictions);
fprintf("\nFalse Predictions %d:", falsePredictions);
fprintf("\nPrecision %d:", truePositives / predictedPositives);
fprintf("\nRecall %d:", truePositives / actualPositives);

             
% =========================================================================


end
