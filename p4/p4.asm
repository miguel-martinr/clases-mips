#Creado en: 20201108
.data

titulo: .asciiz "Practica 4"
pedirF: .asciiz "\nNumero de filas > "
pedirC: .asciiz "\nNumero de columnas > "
dato:   .asciiz "\nDato > "

pedirOpcion: .asciiz "\nOpcion: \n<0>Salir \n<1>Invertir fila \n<2>Invertir columna \n>"
pedirFila: .asciiz "\nFila [1-"
pedirCol:  .asciiz "\nColumna [1-"
corcheteCierre: .asciiz "] > "




saltoLinea: .asciiz "\n"
espacio:    .asciiz "  "

size: .word  4 

.text


main:

#$s0 <- NoFilas
#$s1 <- NoColumnas
#$s2 <- matriz 

#Imprimo titulo
li $v0,4
la $a0,titulo 
syscall 

#Pido filas
li $v0,4
la $a0,pedirF 
syscall 

li $v0,5
syscall 
move $s0,$v0 

#Pido columnas
li $v0,4
la $a0,pedirC
syscall 

li $v0,5
syscall 
move $s1,$v0 


#Reservar espacio matriz 

  #Calcular tamanio de matriz
  mul $a0,$s0,$s1 
  lw  $t0,size 
  mul $a0,$a0,$t0

  #Reservar 
  li $v0,9
  #$a0 <- tamanio de matriz
  syscall 
  move $s2,$v0


#Pido datos de matriz (bucle simple)

# for (int i = 0; i < noFilas*noColumnas; i++)
#     matriz[i]

mul $t1,$s0,$s1 #noFil*noCol
move $t3,$s2 #$t3 <- matriz[0]
li $t0,0
for1:
  bge $t0,$t1,endfor1

  #Iprimir: Dato >
  li $v0,4
  la $a0,dato
  syscall 

  #Leer dato
  li $v0,5
  syscall 
  move $t2,$v0 

  #Guardar dato en matriz 
  sw $t2,0($t3) #store word 

  #Apuntar a siguiente posicion en matriz 
  addi $t3,$t3,4


  addi $t0,$t0,1
  j for1
endfor1:


#$s0 <- NoFilas
#$s1 <- NoColumnas
#$s2 <- matriz 
#$s3 <- seleccion
#$s4 <- f o c
#$s5 <- aux

do1:


  #Imprime matriz 
  move $a1,$s2
  move $a2,$s0
  move $a3,$s1
  jal printMat



  #Pedir opcion 0:Salir 1:Inv fila  2:Inv columna
  
  do2:
    li $v0,4
    la $a0,pedirOpcion
    syscall

    li $v0,5
    syscall 

  blt $v0,$zero,do2
  li $t0,2
  bgt $v0,$t0,do2

  move $s3,$v0

  li $t0,2
  beq $s3,$t0,op2


  #1:Inv fila 
  op1:
    #Pedir fila
    doPedirFila:
      li $v0,4
      la $a0,pedirFila
      syscall

      li $v0,1
      move $a0,$s0
      syscall

      li $v0,4
      la $a0,corcheteCierre
      syscall

      li $v0,5
      syscall
    
    ble $v0,$zero,doPedirFila
    bgt $v0,$s0,doPedirFila

    move $s4,$v0

    #Call Invertir Fila


  endop1:
  j endop2



  #2:Inv columna 
  op2:
      #Pedir columna
    doPedirCol:
      li $v0,4
      la $a0,pedirCol
      syscall

      li $v0,1
      move $a0,$s1
      syscall

      li $v0,4
      la $a0,corcheteCierre
      syscall

      li $v0,5
      syscall
    
    ble $v0,$zero,doPedirCol
    bgt $v0,$s1,doPedirCol

    move $s4,$v0

      #Call Invertir columna 

  endop2:



bne $s3,$zero,do1



















li $v0,10
syscall


#Imprime matriz
#$a1 <- matriz
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


