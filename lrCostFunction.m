function [J, grad] = lrCostFunction(theta, X, y, lambda)
%LRCOSTFUNCTION Compute cost and gradient for logistic regression with 
%regularization
%   J = LRCOSTFUNCTION(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

    m = length(y); % number of training examples

    mod = ones(size(theta));
    mod(1) = 0;

    J = 1 / m * (-y' * log(sigmoid(X * theta)) - (1 - y') * log(1 - sigmoid(X * theta))) + lambda / (2 * m) * (theta' .* mod' * theta);

    grad = 1 / m * ((sigmoid(X * theta) - y)' * X) + lambda / m * theta' .* mod';

    grad = grad(:); % Unroll the gradient

end
