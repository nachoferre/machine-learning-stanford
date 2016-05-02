function [J] = j_calculo(theta1, theta0, x, y)
	
#	fun = @(x) theta1*x + theta0;
#	aux = 0;
#	for i = 1: length(x)
#		aux += (fun(x(i,1)) - y(i,1))^2
#	endfor
#	J = (1/2*length(x)) * aux;

	htheta = (x.* theta1) + theta0;
	temp = htheta - y;
	J = (1/2*length(x)) * sum(temp.^2);

endfunction
