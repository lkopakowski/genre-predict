% Train and run the logistic regression model on the book data.
% This function assumes all book summary and genre data has been processed into the correct files.
% The model is trained for various values of lambda (regularization parameter) and the thresholds
% for which trigger a genre.

clear ; close all; clc
fprintf("Loading data...");
load processedWordsData;
load processedGenreData;
load X;
load Y;

rand = randperm(size(X,1))';

% Randomize X and Y in case the data is ordered in some way.
X = X(rand, :);
Y = Y(rand, :);

% Use the values of lambda here that you want to try on the regression model
lambda_array = [.1 .3 1 3 10 30];

% The output threshold values to try.  If an output value is greater than this threshold, the book is predicted
%the genre at that index
threshold_array = [.1 .2 .3 .4 .5 .6];


% Use the first 60% of the data for training
trainingSize = round(size(X, 1) * .6);
validationIndex = round(size(X, 1) * .8);
X_train = X(1:trainingSize, :);
Y_train = Y(1:trainingSize, :);

performanceFull = [];
for i = 1 : length(lambda_array)
	lambda = lambda_array(i);
	input_layer_size = size(X_train, 2);
	output_layer_size = size(Y_train, 2);
	Theta = multiOutputLogisticRegression(X_train, Y_train, size(Y, 2), lambda);

	X_val = X((trainingSize + 1): validationIndex, :);
	Y_val = Y((trainingSize + 1): validationIndex, :);
	
	fprintf('\nTraining Set Accuracy for lambda: %d', lambda);
	[output predictions performance] = predictLR(Theta, X_train, Y_train, lambda, threshold_array);
    performanceFull = [performanceFull; [performance zeros(size(performance, 1), 1)]];
	
    fprintf('\nValidation Set Accuracy:');
	[output predictions performance] = predictLR(Theta, X_val, Y_val, lambda, threshold_array);
    performanceFull = [performanceFull; [performance ones(size(performance, 1), 1)]];
	fflush(stdout);
end
fprintf("Check optimal lambda and threshold values:\n")
fprintf("lambda threshold precision recall F-measure isVarificationSet\n")
performanceFull
[maxVal index] = max(performanceFull(:, 5));

lambdaBest = performanceFull(index, 1);
thresholdBest = performanceFull(index, 2);

% Get Theta for the optimal value of lambda
Theta = multiOutputLogisticRegression(X_train, Y_train, size(Y, 2), lambdaBest);

fprintf("The model performs optimally with lambda: %d, threshold: %d\n", lambdaBest, thresholdBest);
fflush(stdout);
% Test the optimal parameters on the last 20% of the data
X_test = X((validationIndex + 1): size(X, 1), :);
Y_test = Y((validationIndex + 1): size(X, 1), :);
predictLR(Theta, X_test, Y_test, lambda, [thresholdBest]);

save model.mat performanceFull Theta;
