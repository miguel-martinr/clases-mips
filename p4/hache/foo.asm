#Creado en 20200812
.data

menu: .asciiz  "\nElija una opcion...
                \n <0> Salir
                \n <1> Inv fila
                \n <2> Inv columna
                \n > "

inFilas:  .asciiz "\nFilas >"
inCols:  .asciiz "\nColumnas >"

inDato:  .asciiz "\nDato >"

sel_fila: .asciiz "\nSeleccione fila >"

size:   .word  4
.text

main:

#$s0  <- selection
#$s1  <- nrows
#$s2  <- ncols
#$t0  <- i
#$t1  <- j



#Pedir matriz por teclado 


#Pedir nrows
li $v0,4
la $a0,inFilas
syscall

li $v0,5
syscall

move $s1,$v0


#Pedir ncols
li $v0,4
la $a0,inCols
syscall

li $v0,5
syscall

move $s2,$v0



#$s0  <- selection
#$s1  <- nrows
#$s2  <- ncols
#$s3  <- direccion matriz 
#$s4  <- f
#$t0  <- i
#$t1  <- j

#Reservar espacio para la matriz 

 #Calcular tamanio
#tamanioMatriz = nrows * ncols * size 

mul  $a0,$s1,$s2 
lw $t0,size 

mul  $a0,$a0,$t0 

#reservar espacio
li $v0,9
#$a0 = tamanio 
syscall 

move $s3,$v0



#leer datos (bucle simple)
#$t0 <- i

move $t2,$s3 #Puntero para recorrer matriz

mul $t1,$s1,$s2
move $t0,$zero
for3:
  bge $t0,$t1,for3End

  #Pedir dato
  li $v0,4
  la $a0,inDato
  syscall

  li $v0,5
  syscall

  sw $v0,0($t2)

  addi $t2,4

  addi $t0,1
  j for3
for3End:


do1:

  #Imprimimos matriz
  #Argumentos
  #$a0 <- direccion
  #$a1 <- nFilas
  #$a2 <- nColumnas

  move $a0,$s3
  move $a1,$s1 
  move $a2,$s2
  jal print_mat 


  do2:

    #Imprimimos menu
    li $v0,4
    la $a0,menu 
    syscall

    #Leemos sel
    li $v0,5
    syscall
    move $s0,$v0


    blt $s0,$zero,do2
    li $t0,2
    bgt $s0,$t0,do2

#$s0  <- selection
#$s1  <- nrows
#$s2  <- ncols
#$s3  <- direccion matriz 
#$s4  <- f
#$t0  <- i
#$t1  <- j
  beq $s0,$zero,do1_end

    li $t0,1
    bne $s0,$t0,inv_Col
    #Invierte fila
    do3:

      li $v0,4
      la $a0,sel_fila
      syscall

      li $v0,5
      syscall

      move $s4,$v0

      li $t0,1
      blt $s4,$t0,do3 
      bgt $s4,$s1,do3
    
    addi $s4,-1

    #Poner argumentos para inv_row
    #$a0 <- dir matriz
    #$a1 <- nFilas
    #$a2 <- nCols
    #$a3 <- fila 
    jal inv_row


    j inv_Col_end

    inv_Col:
    #Invierte columna


    inv_Col_end:




bne $s0,$zero,do1
do1_end:































li $v0,10
syscall



#Imprime una matriz
#Argumentos
#$a0 <- direccion
#$a1 <- nFilas
#$a2 <- nColumnas
#Retorna 

#Variables locales
#$t0 <- i
#$t1 <- j
#$t2 <- dir de matriz ($a0)


print_mat:

  
  move $t2,$a0

  #Imprimir salto linea
  li $v0,11
  li $a0,10
  syscall

  move $t0,$zero
  print_matFor1:
    bge $t0,$a1,print_matFor1_end

    move $t1,$zero
    print_matFor2:
      bge $t1,$a2,print_matFor2_end


      #Imprimir valor
      li $v0,1
      lw $a0,0($t2)
      syscall

      #Imprimimos dos espacios
      li $v0,11
      li $a0,32
      syscall 
      syscall


      addi $t2,4


      addi $t1,1
      j print_matFor2
    print_matFor2_end:


    #Imprimir salto linea
    li $v0,11
    li $a0,10
    syscall
  

    addi $t0,1
    j print_matFor1
  print_matFor1_end:

  #Imprimir salto linea
  li $v0,11
  li $a0,10
  syscall

jr $ra 



inv_row:



jr $ra














