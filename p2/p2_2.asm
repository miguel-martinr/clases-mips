.data

cadena1:  .asciiz   "Introduzca la cifra a buscar (numero de 0 a 9): "
cadena2:  .asciiz    "Introduzca un entero positivo donde se realizara la busqueda: "
cadena3:  .asciiz   "Numero de veces encontrado: "

.text

main:


  #$s0 <-  cifra //Numero a buscar
  #$s1 <-  numero //Numero en el que buscar
  #$s3 <-  encontrado



do1:

  #Imprimir cadena
  la $a0,cadena1
  li $v0,4
  syscall
  
  #Leer entero
  li $v0,5
  syscall

  blt $v0,$zero,do1
  li $t0,9
  bgt $v0,$t0,do1


  move $s0,$v0



  #$s0 <-  cifra //Numero a buscar
  #$s1 <-  numero //Numero en el que buscar
  #$s3 <-  encontrado
  #$s4 <-  resto


do2:

  #Imprimir cadena
  la $a0,cadena2
  li $v0,4
  syscall

  #Leer entero
  li $v0,5
  syscall
  blt $v0,$zero,do2

  move $s1,$v0


  move $s3,$zero




do3:
  li $t0,10
  div $s1,$t0
  mfhi $s4	
  mflo $s1 

  bne $s4,$s0,endif
  addi $s3,1
endif:


  bne $s1,$zero,do3


  #Imprimir cadena
  la $a0,cadena3
  li $v0,4
  syscall

  li $v0,1
  move $a0,$s3 
  syscall





  li $v0,10 
  syscall

  


