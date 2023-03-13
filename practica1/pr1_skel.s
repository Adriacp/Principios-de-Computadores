# Autor: ADRIÁN MANUEL ACUÑA PERDOMO
# Correo electrónico: alu0101592084@ull.edu.es
# Fecha:08/03/23

##include<iostream>
##include<cmath>

#int main(void) {
#    std::cout << "\n\nAproximación a sen(x) (-1 <= x <= 1) con un error máximo, usando Taylor\n";
#    do {
#    	double x;
#        do {
#        std::cout << "\n\nIntroduzca el valor de x (-1 <= x <= 1): ";
#        std::cin >> x;
#        } while ( (x < -1) || (x > 1));
#        double error;
#        do {
#            std::cout << "\nIntroduzca el error maximo permitido en la aproximación (0 < error < 1) (error <= 0 sale del programa): ";
#            std::cin >> error;
#        } while (error >= 1);
#        if (error <= 0) break;
#        int n = 0; // iteraciones
#        double numerador = x; // primer numerador del termino para n=0
#        int denominador = 1; // primer denominador del termino para n=0
#        int signo = 1;
#        double sen_x = x; // primer termino
#        double xx = x*x; // el numerador siempre se multiplica por x^2 
#        double error_calculado;
#        do {
#            double old_senx = sen_x;
#            n++; // incremento el termino
#            signo = -signo; // el signo se alterna
#            numerador *= xx; 
#            denominador = (2*n+1) * 2*n * denominador;
#            double termino = signo * numerador / denominador; // ultimo termino
#            sen_x += termino;
#            error_calculado = fabs((sen_x - old_senx) / sen_x);
#        } while (error_calculado >= error);
#        std::cout << "\n\n\nsen(x) calculado: " << sen_x;
#        std::cout << "\nerror calculado: " << error_calculado;
#        std::cout << "\nnumero de iteraciones calculadas: " << n;
#    } while (true);
#    std::cout << "\nFin del programa\n";
#    return 0;
#}
#double x => $f20
#int n => $s0
#double error => $f6
#double numerador => $f4
#int denominador => $t5
#int signo => $t6
#double sen_x => $f22
#double xx => $f24
#double error_calculado => $f26
#double old_senx => $f6
#double termino => $f8

    .data
titulo: .asciiz "\n\nAproximación a sen(x) (-1 <= x <= 1) con un error máximo, usando Taylor\n"
petx:   .asciiz "\n\nIntroduzca el valor de x (-1 <= x <= 1): "
pete:   .asciiz "\nIntroduzca el error maximo permitido en la aproximación (0 < error < 1) (error <= 0 sale del programa): "
cadsen: .asciiz "\n\n\nsen(x) calculado: "
caderr: .asciiz "\nerror calculado: "
cadite: .asciiz "\nnumero de iteraciones calculadas: "
cadfin: .asciiz "\nFin del programa\n"
    
    .text
#int main(void) {
main:
#    std::cout << "\n\nAproximación a sen(x) (-1 <= x <= 1) con un error máximo, usando Taylor\n";
	li $v0, 4
	la $a0, titulo
	syscall
#    do {
	do_while_1:
#    	double x;
	li.d $f20, 0.0
#        do {
		do_while_2:
#        std::cout << "\n\nIntroduzca el valor de x (-1 <= x <= 1): ";
			li $v0, 4
			la $a0, petx
			syscall
#        std::cin >> x;$f20
			li $v0, 7
			syscall
			mov.d $f20, $f0
#        } while ( (x < -1) || (x > 1));
			li.d $f4, -1.0
			c.lt.d $f20, $f4
			bc1t do_while_2
			neg.d $f4, $f4
			c.le.d $f20, $f4
			bc1t do_while_2_fin
			j do_while_2
	do_while_2_fin:
#        double error;
	li.d $f22, 0.0
#        do {
	do_while_3:
#            std::cout << "\nIntroduzca el error maximo permitido en la aproximación (0 < error < 1) (error <= 0 sale del programa): ";
				li $v0, 4
				la $a0, pete
				syscall
#            std::cin >> error;
				li $v0, 7
				syscall
				mov.d $f22, $f0
#        } while (error >= 1);
				li.d $f4, 1.0
				c.lt.d $f22, $f4
				bc1t do_while_3_fin
				j do_while_3
	do_while_3_fin:
#        if (error <= 0) break;
				li.d $f0, 0.0
				c.le.d $f22, $f0
				bc1t do_while_1_fin
#----------------------------------------------------------------------------------------------------------------------------------------------
#        int n = 0; // iteraciones
				li.d $f0, 0.0
#        double numerador = x; // primer numerador del termino para n=0
				mov.d $f24, $f20
#        int denominador = 1; // primer denominador del termino para n=0
				li.d $f2, 1.0
#        int signo = 1;
				li.d $f4, 1.0
#        double sen_x = x; // primer termino
				mov.d $f26, $f20
#        double xx = x*x; // el numerador siempre se multiplica por x^2
				mul.d $f20, $f20, $f20 
#        double error_calculado;
#        do {
				do_while_4:
#            double old_senx = sen_x;
					mov.d $f28, $f26
#            n++; // incremento el termino
					li.d $f6, 1.0
					add.d $f0, $f0, $f6
#            signo = -signo; // el signo se alterna
					neg.d $f4, $f4
#            numerador *= xx; 
					mul.d $f24, $f24, $f20
#            denominador = (2*n+1) * 2*n * denominador;
					li.d $f8, 2.0
					mul.d $f8, $f8, $f0
					li.d $f10, 1.0
					mov.d $f14, $f8
					add.d $f8, $f8, $f10
					mul.d $f8, $f8, $f14
					mul.d $f2, $f2, $f8
#            double termino = signo * numerador / denominador; // ultimo termino
					div.d $f16, $f24, $f2
					mul.d $f16, $f16, $f4 
#            sen_x += termino;
					add.d $f26, $f26, $f16
#            error_calculado = fabs((sen_x - old_senx) / sen_x);
					sub.d $f28, $f26, $f28
					div.d $f28, $f28, $f26
					abs.d $f28, $f28
#        } while (error_calculado >= error);
					c.lt.d $f28, $f22
					bc1t do_while_4_fin
					j do_while_4
	do_while_4_fin:
#        std::cout << "\n\n\nsen(x) calculado: " << sen_x;
				mov.d $f20, $f0
    				li $v0, 4
    				la $a0, cadsen
    				syscall
    				li $v0, 3
    				mov.d $f12, $f26
    				syscall
#        std::cout << "\nerror calculado: " << error_calculado;
				 li $v0, 4
    				 la $a0, caderr
   				 syscall
  				 li $v0, 3
   				 mov.d $f12, $f28
   				 syscall
#        std::cout << "\nnumero de iteraciones calculadas: " << n;
				li $v0, 4
    				la $a0, cadite
   				syscall
    				li $v0, 3
    				mov.d $f12, $f20
    				syscall
#    } while (true);
	j do_while_1
do_while_1_fin:
#    std::cout << "\nFin del programa\n";
		li $v0, 4
  		la $a0, cadfin
  		syscall
#    return 0;

		li $v0, 10
		syscall
#}
