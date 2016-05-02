clear ; close all; clc

data = load('ex2data1.txt');
X = data(:, [1,2]);
Y = data(:, 3);
negativos = find ( Y==0) ;
figure;
hold on;
plot (X( negativos , 1) , X( negativos , 2) , 'ko' , 'MarkerFaceColor' , 'y' , ...
'MarkerSize' , 4) ;
positivos = find ( Y==1) ;
plot (X( positivos , 1) , X( positivos , 2) , 'k+' ,  'LineWidth', 2, ...
'MarkerSize' , 4) ;
xlabel('Exam 1 score')
ylabel('Exam 2 score')
legend('Admited', 'Not admited')
hold off;
%func sigmoide
%g = 1 ./ (1+ exp(-z));
%f coste y grad
[m, n] = size(X);
X = [ones(m, 1), X];
theta = zeros(n+1, 1);
[J, grad] = Coste(theta, X, Y)
%fminunc
opciones = optimset('GradObj', 'on', 'MaxIter', 400);
[theta, J] = fminunc(@(t)(Coste(t,X,Y)), theta, opciones);
plotDecisionBoundary(theta, X, Y);
ej = 1 ./ (1+ exp(-(X*theta)));
estimacion = (ej>=0.5);
bien = sum(estimacion==Y)*100/length(Y)
