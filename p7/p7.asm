#Creado en 20200812
.data

inFilas: .asciiz "\nFilas > "
inCols:  .asciiz "\nColumnas > "

indato:  .asciiz  "\nDato > "

indato1: .asciiz "\nDato["
indato2: .asciiz "]["
indato3: .asciiz "] > "

resultado: .asciiz "\nResultado = "

saltoLinea: .asciiz "\n"
espacio:    .asciiz "  "

size:    .word 4

.text

main:

#$s0 <- noFilas
#$s1 <- noColumnas

do1:
  #Imprimir cadena
  li $v0,4
  la $a0,inFilas
  syscall 

  #Leer entero
  li $v0,5
  syscall 

  move $s0,$v0

  #Imprimir cadena
  li $v0,4
  la $a0,inCols
  syscall 

  #Leer entero
  li $v0,5
  syscall 

  move $s1,$v0

blt $s0,$zero,do1
blt $s1,$zero,do1

#$s0 <- noFilas
#$s1 <- noColumnas
#$s2 <- direccion matriz

# Definir matriz en memoria
  #Calculamos el tamanio de la matriz (noFilas*noCols*size)
  lw $a0,size
  mul $a0,$a0,$s0
  mul $a0,$a0,$s1
  
  #Reservamos el espacio con sbrk 
  li $v0,9
  #$a0 <- noFilas*noCols*size
  syscall

  move $s2,$v0 


  #Bucle simple para pedir datos de la matriz 
  #$t0 <- i
  #$t1 <- noFilas*noCols
  #$t3 <- puntero para recorrer matriz

  mul $t1,$s0,$s1
  move $t3,$s2

  move $t0,$zero
  for1:
    bge $t0,$t1,endfor1

    #Pedimos el dato >
    li $v0,4
    la $a0,indato 
    syscall

    li $v0,5
    syscall

    sw $v0,0($t3)

    addi $t3,4
    addi $t0,1
    j for1
  endfor1:


  #Imprimimos la matriz con la subrutina printMat
  move $a1,$s2
  move $a2,$s0
  move $a3,$s1
  jal printMat


  move $a1,$s2
  move $a2,$s0
  move $a3,$s1
  jal sum 

  #Imprimimos el resultado
  li $v0,4
  la $a0,resultado
  syscall

  li $v0,2
  mov.s $f12,$f0
  syscall



li $v0,10
syscall




#Divide entre dos y devuelve flotante
#Parametros
#$a1 <- entero 
#Retorna
#$f0 <- entero/2
div_by_two:
  mtc1 $a1,$f0
  cvt.s.w $f0,$f0

  li.s $f4,2.0
  div.s $f0,$f0,$f4

div_by_two_end:
jr $ra


#Devuelve la suma(float) de todos los valores de una matriz
#de enteros divididos entre dos
#Parametros
#$a1 <- dir matriz
#$a2 <- noFilas
#$a3 <- noCols
#Retorna
#$f0 <- suma

#$f20 <- res
#$s0 <- nFil*nCols
#$s1 <- i
#$s2 <- dirMatriz
sum:
  addi $sp,-20
  sw $s0,0($sp)
  sw $s1,4($sp)
  swc1 $f20,8($sp)
  sw $s2,12($sp)
  sw $ra,16($sp)

  li.s $f20,0.0
  move $s2,$a1
  mul $s0,$a2,$a3
  move $s1,$zero
  sumFor1:
    bge $s1,$s0,sumFor1End

    lw $a1,0($s2)
    jal div_by_two

    add.s $f20,$f20,$f0
    
    addi $s2,4
    addi $s1,1
    j sumFor1
  sumFor1End:

  mov.s $f0,$f20

endsum:
  lw $s0,0($sp)
  lw $s1,4($sp)
  lwc1 $f20,8($sp)
  lw $s2,12($sp)
  lw $ra,16($sp)
  addi $sp,20

jr $ra











#Imprime matriz
#$a1 <- direccion de matriz
#$a2 <- noFilas
#$a3 <- noColumnas

#Variables locales
#$t0 <- i
#$t1 <- j
printMat:
  li $v0,4
  la $a0,saltoLinea
  syscall 

  li $t0,0
  printMatFor1:
    bge $t0,$a2,printMatEndFor1

    li $t1,0
    printMatFor2:
      bge $t1,$a3,printMatEndFor2

      #Imprime numero
      li $v0,1
      lw $a0,0($a1)
      syscall 
     
      #Imprime espacio
      li $v0,4
      la $a0,espacio
      syscall 

      addi $a1,4 

      addi $t1,1
      j printMatFor2
    printMatEndFor2:  

    #Imprime salto de linea
    li $v0,4
    la $a0,saltoLinea
    syscall


    addi $t0,1
    j printMatFor1
  printMatEndFor1:

  jr $ra






































# #Doble bucle para pedir datos de la matriz
# #$t0 <- i
# #$t1 <- j
# #$t2 <- puntero para recorrer matriz

# move $t2,$s2
# move $t0,$zero 
# for1:
#   bge $t0,$s0,endfor1

#   move $t1,$zero
#   for2:
#     bge $t1,$s1,endfor2

#     #Pedimos dato[i][j] >
#     li $v0,4
#     la $a0,indato1
#     syscall

#     li $v0,1
#     move $a0,$t0
#     syscall

#     li $v0,4
#     la $a0,indato2
#     syscall

#     li $v0,1
#     move $a0,$t1
#     syscall

#     li $v0,4
#     la $a0,indato3
#     syscall

#     li $v0,5
#     syscall

#     #Lo guardamos en la matriz
#     sw $v0,0($t2)

#     addi $t2,4 #Apuntamos a la siguiente posicion

#     addi $t1,1
#     j for2
#   endfor2:

#   addi $t0,1
#   j for1
# endfor1:
