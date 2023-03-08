##// Programa para evaluar polinomio tercer grado
##
###include <iostream>
##int main(void) {
##  float a,b,c,d;
##  std::cout << "\nEvaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]\n";
##  std::cout << "\nIntroduzca los valores de a,b,c y d (separados por retorno de carro):\n";
##  std::cin >> a;
##  std::cin >> b;
##  std::cin >> c;
##  std::cin >> d;
##  int r,s;
##  do {
##    std::cout << "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro):\n";
##    std::cin >> r;
##    std::cin >> s;
##  } while (r > s);
##  for (int x = r ; x <= s ; x++) {
##    float f = a*x*x*x + b*x*x + c*x + d;
##    if (f >= 2.1) {
##      std::cout << "\nf(" << x << ") = " << f;
##    }
##  }
##  std::cout << "\n\nTermina el programa\n";
##}

#Asignacion de variables a registros
#a -> $f20
#b -> $f22
#c -> $f24
#d -> $f26
#f -> $f28
#r -> $s0
#s -> $s1
#x -> $s2

	.data
strTitulo:	.asciiz "\nEvaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]\n"
strIntroabcd:	.asciiz "\nIntroduzca los valores de a,b,c y d (separados por retorno de carro):\n"
strIntrors:	.asciiz "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro):\n"
funcion1:		.asciiz "\nf("
funcion2:	.asciiz ") = "
strFin:		.asciiz "\n\nTermina el programa\n"
comp:		.float 2.1
	.text
main:
##  std::cout << "\nEvaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]\n";
##  std::cout << "\nIntroduzca los valores de a,b,c y d (separados por retorno de carro):\n";
	li $v0, 4
	la $a0, strTitulo
	syscall
	
	li $v0, 4
	la $a0, strIntroabcd
	syscall
##  std::cin >> a;
	li $v0, 6
	syscall
	mov.s $f20, $f0
##  std::cin >> b;
	li $v0, 6
	syscall
	mov.s $f22, $f0
##  std::cin >> c;
	li $v0, 6
	syscall
	mov.s $f24, $f0
##  std::cin >> d;
	li $v0, 6
	syscall
	mov.s $f26, $f0

##  int r,s;
##  do {
dowhile:
##    std::cout << "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro):\n";
	li $v0, 4
	la $a0, strIntrors
	syscall
##    std::cin >> r;
	li $v0, 5
	syscall
	move $s0, $v0
##    std::cin >> s;
	li $v0, 5
	syscall
	move $s1, $v0
##  } while (r > s);
	bgt	$s0, $s1, dowhile
##  for (int x = r ; x <= s ; x++) {
##    float f = a*x*x*x + b*x*x + c*x + d;
#nos traemos x al coprocesador -> $f6
	move $s2, $s0
for:
	bgt $s2, $s1, forfin

	mtc1 $s2, $f4
	cvt.s.w $f6, $f4

	mov.s	$f28, $f26		#f=d

	mul.s	$f8, $f24, $f6		#$f8 = c*x
	add.s	$f28, $f28, $f8		#f= f+ $f28 = f+ c*x

	mul.s	$f10, $f6, $f6		#$f10 = x*x
	mul.s	$f16, $f22, $f10	#$f16 = b * $f10= b*x*x
	add.s	$f28, $f28, $f16	#f= f + $f16 = f+ b*x*x

	mul.s	$f10, $f10, $f6		#$f10 = $f10 * x= x*x*x
	mul.s	$f16, $f20, $f10	#$f16 = a* $f10 = a*x*x*x
	add.s	$f28, $f28, $f16	#f = f+$f16 = f + a*x*x*x	

	l.s $f8, comp
	c.lt.s $f28, $f8
	bc1t outIf

	li $v0, 4
	la $a0, funcion1
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall

	li $v0, 4
	la $a0, funcion2
	syscall

	li $v0, 2
	mov.s $f12, $f28
	syscall

outIf: 
	addi $s2, $s2, 1
	b for
forfin:

## el if esta dentro del bucle for
##    if (f >= 2.1) {
##      std::cout << "\nf(" << x << ") = " << f;
##    }
##  }
##  std::cout << "\n\nTermina el programa\n";
##}
	li $v0, 4
	la $a0, strFin
	syscall

	li $v0, 10
	syscall
