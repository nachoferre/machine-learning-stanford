clear ; close all; clc

data = load('ex2data2.txt');
X = data(:, [1, 2]);
Y = data(:, 3);

positivos = find(Y == 1); 
negativos = find(Y == 0);
figure;
hold on;
plot (X( negativos , 1) , X( negativos , 2) , 'ko' , 'MarkerFaceColor' , 'y' , ...
'MarkerSize' , 4) ;
plot (X( positivos , 1) , X( positivos , 2) , 'k+' ,  'LineWidth', 3, ...
'MarkerSize' , 4) ;
%lo ponemos bonito
xlabel('Microchip-1')
ylabel('Microchip-2')
legend('y = 1', 'y = 0')
hold off;

%mapeamos los atributos
X = mapFeature(X(:,1), X(:,2));

lambda = 1;
theta = zeros(size(X, 2), 1);
[J, grad] = coste_reg(theta, X, Y, lambda)

theta = zeros(size(X, 2), 1);
lambda = 1;

opciones = optimset('GradObj', 'on', 'MaxIter', 400);
[theta, J] = fminunc(@(t)(coste_reg(t,X,Y, lambda)), theta, opciones);
plotDecisionBoundary(theta, X, Y);

hold on;
title(sprintf('lambda = %g', lambda))

% Labels and Legend
xlabel('Microchip Test 1')
ylabel('Microchip Test 2')

legend('y = 1', 'y = 0', 'Decision boundary')
hold off;