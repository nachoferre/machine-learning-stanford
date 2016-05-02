clear ; close all; clc
input_layer_size  = 400;  
hidden_layer_size = 25;  
num_labels = 10; 
fprintf('Loading and Visualizing Data ...\n')
load('ex3data1.mat');
m = size(X, 1);
sel = randperm(size(X, 1));
sel = sel(1:100);
displayData(X(sel, :));
fprintf('Program paused. Press enter to continue.\n');
pause;
fprintf('\nLoading Saved Neural Network Parameters ...\n')
load('ex3weights.mat');
pred = predict(Theta1, Theta2, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);
fprintf('Program paused. Press enter to continue.\n');
pause;
rp = randperm(m);
for i = 1:m //Que es esto?
    fprintf('\nDisplaying Example Image\n');
    displayData(X(rp(i), :));
    pred = predict(Theta1, Theta2, X(rp(i),:));
    fprintf('\nNeural Network Prediction: %d (digit %d)\n', pred, mod(pred, 10));
    fprintf('Program paused. Press enter to continue.\n');
    pause;
end

function p = predict(Theta1, Theta2, X)

	m = size(X, 1);
	num_labels = size(Theta2, 1);
	p = zeros(size(X, 1), 1);
	X = [ones(size(X,1),1) X];
	a_2 = sigmoid(X * Theta1');
	a_2 = [ones(size(a_2,1),1) a_2];
	match = sigmoid(a_2 * Theta2');
	[x, p] = max(match');
	p = p';
end
