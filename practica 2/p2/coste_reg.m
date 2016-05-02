function [J, grad] = coste_reg(theta, X, Y, lambda)
m = length(Y);
n = size(theta);

grad = zeros(n);

h_theta = 1 ./ (1+ exp(-(X*theta)));
theta(1) = 0;

J = (1/m)*sum(-Y .*log(h_theta) .- (1.-Y).*log(1.-h_theta)) + ((lambda/(2*m))*sum(theta.^2));
grad = (1/m)* (X'*(h_theta .- Y) + lambda*theta);

end