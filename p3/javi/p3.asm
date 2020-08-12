.data
str1: .asciiz "Introduzca los valores de a,b,c y d (separados por retorno de carro) > \n"
str2: .asciiz "Introduzca r y s > \n"
str3: .asciiz "\nf("
str4: .asciiz ") = "

.text

main:

  #Imprimir cadena
  la $a0,str1
  li $v0,4
  syscall



  #f20 - f23  <- a,b,c,d
  li $v0,6
  syscall 
  mov.s $f20,$f0

  li $v0,6
  syscall 
  mov.s $f21,$f0

  li $v0,6
  syscall 
  mov.s $f22,$f0

  li $v0,6
  syscall 
  mov.s $f23,$f0


do1:

  #Imprimir cadena
  la $a0,str2
  li $v0,4
  syscall

  #$s0 <- r
  #$s1 <- s

  li $v0,5
  syscall
  move $s0,$v0 
  
  li $v0,5
  syscall
  move $s1,$v0 

  bgt $s0,$s1,do1


#$f24 <- f
#$s2  <- x 
#$f25 <- resultado 

move $s2,$s0
for1:
  bgt $s2,$s1,endfor1
  #f = a*x*x*x + b*x*x + c*x + d

  mtc1 $s2,$f24 
  cvt.s.w $f24,$f24 


  mul.s $f25,$f20,$f24
  mul.s $f25,$f25,$f24
  mul.s $f25,$f25,$f24

  mov.s $f4,$f25 

  mul.s $f25,$f21,$f24
  mul.s $f25,$f25,$f24

  add.s $f4,$f4,$f25 

  mul.s $f25,$f22,$f24

  add.s $f4,$f4,$f25 
  add.s $f25,$f4,$f23
 
  #Imprimir cadena f(
  li $v0,4
  la $a0,str3
  syscall

  #Imprimir x 
  li $v0,1
  move $a0,$s2
  syscall

  
  #Imprimir cadena ) = 
  li $v0,4
  la $a0,str4
  syscall

  #Imprimir float
  li $v0,2
  mov.s $f12,$f25
  syscall

  
  addi $s2,$s2,1
  j for1
endfor1:



  li $v0,10
  syscall