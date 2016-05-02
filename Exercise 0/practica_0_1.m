#COMENTARIOS
function [I] = practica_0_1 (fun, a, b, num_puntos)
	ini = time()
  v = [a:0.1:b];
	fv = fun(v);
	h = max(fv);
	x = rand(1,num_puntos) * (b-a);
	y = rand(1,num_puntos) * (h);
  fx = fun(x);
	#poner grafica bonita
	#medir tiempo ==> hecho
	contd=0;
	for i = 1: num_puntos
		if (y(1,i) < fx(1,i))
			contd = contd + 1;
		endif																																		
	endfor
  plot(v, fv,"linewidth", 4, x, y, "x", "color", "red", "linewidth", 4);
  set(gca, "fontsize", 15);
  title("Practica - 0 While", "fontsize", 20);
  legend("f(x)");
  xlabel( "x - axis", "fontsize", 15);
  ylabel( "f(x) - y axis", "fontsize", 15);
	#Dibujar puntos
  printf("num = %d\n", contd);
	I = (contd/num_puntos) * (b-a) * h;
  fin = time()
  printf('Total cpu time: %f seconds\n', fin-ini);
	print("prueba_while.png","-dpng");
	
endfunction

