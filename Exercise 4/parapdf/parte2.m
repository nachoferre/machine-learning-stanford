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
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
s = 0;
for i=1:m,
    x_i = [1 X(i,:)]';    
    y_i = zeros(num_labels, 1);
    y_i(y(i)) = 1;    
    z_2 = Theta1 * x_i;
    a_2 = [1; sigmoid(z_2)];    
    z_3 = Theta2 * a_2;
    h = sigmoid(z_3);    
    d_3 = h - y_i;
    d_2 = Theta2' * d_3;
    d_2 = d_2(2:end) .* sigmoidGradient(z_2);    
    Theta2_grad = Theta2_grad + (d_3 * a_2');
    Theta1_grad = Theta1_grad + (d_2 * x_i');    
    s = s + sum(-y_i .* log(h) .- (1.-y_i) .* log(1.-h));
end
t_1 = Theta1(:,2:end);
t_2 = Theta2(:,2:end);
Theta1_grad = [Theta1_grad(:,1)/m ((Theta1_grad(:,2:end)/m) + (lambda/m) * t_1)];
Theta2_grad = [Theta2_grad(:,1)/m ((Theta2_grad(:,2:end)/m) + (lambda/m) * t_2)];
t_1 = sum(sum(t_1.^2));
t_2 = sum(sum(t_2.^2));
r = (lambda/(2*m))*(t_1 + t_2);
J = (1/m) * s + r;
grad = [Theta1_grad(:) ; Theta2_grad(:)];
end
--------------------------------------------------
function g = sigmoidGradient(z)

g = zeros(size(z));
g = sigmoid(z) .* (1.0 .- sigmoid(z));
end
----------------------------------------------------
function W = randInitializeWeights(L_in, L_out)

W = zeros(L_out, 1 + L_in);
epsilon_init = 0.12;
W = rand(L_out, 1 + L_in) * 2 * epsilon_init - epsilon_init;
end
------------------------------------------------------------





