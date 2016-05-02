clear ; close all; clc
input_layer_size  = 400;
hidden_layer_size = 25; 
num_labels = 10;
load('ex4data1.mat');
m = size(X, 1);
sel = randperm(size(X, 1));
sel = sel(1:100);
displayData(X(sel, :));
load('ex4weights.mat');
nn_params = [Theta1(:) ; Theta2(:)];
lambda = 0;
J = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
                   num_labels, X, y, lambda);
%Regularizada
lambda = 1;
J = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
                   num_labels, X, y, lambda);
%chekeo
checkNNGradients;
%chekeo regularizada
lambda = 3;
checkNNGradients(lambda);
% Also output the costFunction debugging values
debug_J  = nnCostFunction(nn_params, input_layer_size, ...
                          hidden_layer_size, num_labels, X, y, lambda);

fprintf(['\n\nCost at (fixed) debugging parameters (w/ lambda = 10): %f ' ...
         '\n(this value should be about 0.576051)\n\n'], debug_J);
fprintf('\nTraining Neural Network... \n')
%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', 50);

%  You should also try different values of lambda
lambda = 1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================= Part 9: Visualize Weights =================
%  You can now "visualize" what the neural network is learning by 
%  displaying the hidden units to see what features they are capturing in 
%  the data.

fprintf('\nVisualizing Neural Network... \n')

displayData(Theta1(:, 2:end));

fprintf('\nProgram paused. Press enter to continue.\n');
pause;
				
--------------------------------------------------------		
function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
								   
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
m = size(X, 1);
J = 0;
s = 0;
for i=1:m,
    x_i = [1 X(i,:)]';
    y_i = zeros(num_labels, 1);
    y_i(y(i)) = 1;    
    z_2 = Theta1 * x_i;
    a_2 = [1; sigmoid(z_2)];    
    z_3 = Theta2 * a_2;
    h = sigmoid(z_3);       
    s = s + sum(-y_i .* log(h) .- (1.-y_i) .* log(1.-h));
end
t_1 = Theta1(:,2:end);
t_2 = Theta2(:,2:end);
t_1 = sum(sum(t_1.^2));
t_2 = sum(sum(t_2.^2));
r = (lambda/(2*m))*(t_1 + t_2);
J = (1/m) * s + r;
end
------------------------------------------------------------------
function g = sigmoid(z)

g = 1.0 ./ (1.0 + exp(-z));
end