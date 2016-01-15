%function predictGenreFromSummary()
% Takes the trained model and uses it to predict a book's genre from its plot summary.
clear ; close all; clc
fprintf("Loading data...");
load model.mat;
load processedWordsData;
load processedGenreData;

summary = loadStringFromFile("yourPlotSummary.txt");

% Create a cell array out of the input plot summary
summaryCellArray = cell(1 , 1);
summaryCellArray{1} = summary;

% Generate the input parameters for the model from the plot summary
wordIndicesByBook = getWordIndicesPerBook(summaryCellArray, words);
X = zeros(1, length(words));
X(1, wordIndicesByBook{1}) = 1;
X = [1 X];

% Use the model to get the output values
output = sigmoid(X * Theta');
output = output > .2;
genreIndices = find(output);


% Get the genres for the output values
matchedGenres = genresToUse(genreIndices);
fprintf("Predicted Genres for Book:\n");
matchedGenres
