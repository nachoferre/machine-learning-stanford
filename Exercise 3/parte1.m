clear ; close all; clc
input_layer_size  = 400;
num_labels = 10;
fprintf('Loading and Visualizing Data ...\n')
load('ex3data1.mat');
m = size(X, 1);
rand_indices = randperm(m);
sel = X(rand_indices(1:100), :);
displayData(sel);
fprintf('Program paused. Press enter to continue.\n');
pause;
fprintf('\nTraining One-vs-All Logistic Regression...\n')
lambda = 0.1;
[all_theta] = oneVsAll(X, y, num_labels, lambda);
fprintf('Program paused. Press enter to continue.\n');
pause;
pred = predictOneVsAll(all_theta, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);


function [all_theta] = oneVsAll(X, y, num_labels, lambda)

	m = size(X, 1);
	n = size(X, 2);
	all_theta = zeros(num_labels, n + 1);
	X = [ones(m, 1) X];
	initial_theta = zeros(n + 1, 1);
	options = optimset('GradObj', 'on', 'MaxIter', 50);
	for c = 1:num_labels //No hay que hacer fors, porque haces fors?
	  [theta] = fmincg (@(t)(lrCostFunction(t, X, (y == c), lambda)), initial_theta, options);
	  all_theta(c,:) = theta;
	end
end

function [J, grad] = lrCostFunction(theta, X, y, lambda)

	m = length(y);
	J = 0;
	grad = zeros(size(theta));
	h = sigmoid(X * theta);
	theta(1) = 0;
	J = (1/m)*sum(-y.*log(h) .- (1.-y).*log(1.-h)) + ((lambda/(2*m))*sum(theta.^2));
	grad =(1/m)*(X'*(h .- y)) + (lambda/m)*theta; //a lo mejor hay que quitar /m
	grad = grad(:);
end

function g = sigmoid(z)

	g = 1.0 ./ (1.0 + exp(-z));
end

function p = predictOneVsAll(all_theta, X)

	m = size(X, 1);
	num_labels = size(all_theta, 1);
	p = zeros(size(X, 1), 1);
	X = [ones(m, 1) X];
	for i=1:m, //No for, porque for?
	    [x, p(i)] = max(sigmoid(all_theta * X(i,:)'));
	end
end
