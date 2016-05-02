#COMENTARIOS
function [I] = practica_0_2 (fun, a, b, num_puntos)
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
	contd = length(find(y<fx));	
	#Dibujar puntos
  plot(v, fv,"linewidth", 4, x, y, "x", "color", "red", "linewidth", 4);
  set(gca, "fontsize", 15);
  title("Practica - 0 Vector", "fontsize", 20);
  legend("f(x)");
  xlabel( "x - axis", "fontsize", 15);
  ylabel( "f(x) - y axis", "fontsize", 15);
  printf("num = %d\n", contd);
	I = (contd/num_puntos) * (b-a) * h; 
  fin = time();
  printf('Total cpu time: %f seconds\n', fin-ini);
	print("prueba_vector.png","-dpng");
	
endfunction

