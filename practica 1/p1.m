function [J] = p1
	fich = dlmread ('ex1data1.txt',',');
	x = fich(:,1);
	y = fich(:,2);
	m = length(x);
# x = [ones(m,1), x]
# theta = zeros (2,1)
#theta' * x
	#plot(x,y,"x","color","red","linewidth",2);
	a = 0.01
	T0=0;
	T1=0;
	T0a=0;
	T1a=0;
	for i=1:1500
		h0 = (x.*T1).+ T0;
		T0 = T0a .- (sum((h0.-y)).*(a/m));
		T1 = T1a .- (sum((h0.-y).*x).*(a/m));
		T0a = T0;
		T1a = T1;
		J = j_calculo(T0,T1,x,y)
 	endfor
#	plot(T0,T1,"x","color","blue","linewidth",2)
	J = j_calculo(T0,T1,x,y);
	
endfunction
