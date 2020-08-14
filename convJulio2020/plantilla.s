# definiciones constantes que puedes usar en tu programa
lado=7  # esta es la dimension del laberinto lado x lado
muro=35  # este entero corresponde con el ascii del caracter muro #
libre=48 # este entero corresponde con el ascii del caracter camino libre 0
marca=88 # este entero corresponde con el ascii del caracter camino recorrido X
newline=10  # este entero corresponde con el ascii del salto de linea, equivalente a un \n

# EJEMPLO DE USO PARA IMPRIMIR UN CARACTER POR CONSOLA
# para imprimir un caracter usar la llamada al sistema 11. Por ejemplo, para imprimir un newline
# li $a0,newline
# li $v0,11
# syscall

	.data
# El camino del labderinto debe empezar siempre en la esquina superior izquierda
# debe tener solucion, que consistira en tener fin en la ultima columna
# Debe ademas ser una matriz cuadrada de dimension lado x lado (lado se define anteriormente)
laberinto:	.ascii "0######"
			      .ascii "00##000"
			      .ascii "#0##0##"
			      .ascii "#0##0##"
			      .ascii "#0000##"
			      .ascii "#######"
			      .ascii "#######"
			
costeh:		.asciiz "\nIntroduzca el coste del desplazamiento horizontal: "
costev:		.asciiz "\nIntroduzca el coste del desplazamiento vertical: "
resultado:	.asciiz "\nCoste del laberinto: "
fin:		.asciiz "\nFin."

size:   .word  1

	.text
	
# Desarrolla la funcion print_matriz
# ESPECIFICA AQUI LOS ARGUMENTOS DE ENTRADA Y SALIDA COMO COMENTARIOS

#Imprime una matriz cuadrada
#Argumento
#$a1 <- dir de matriz
#$a2 <- numero de filas (igual al de columnas)

#Variables locales
#$t0 <- i
#$t1 <- j
print_matriz:

  #Imprime salto de linea
  li $v0,11
  li $a0,newline
  syscall

  move $t0,$zero
  print_for1: 
    bge $t0,$a2,print_for1End

    move $t1,$zero
    print_for2:
      bge $t1,$a2,print_for2End

      li $v0,11
      lb $a0,0($a1)
      syscall

      addi $a1,1

      addi $t1,1
      j print_for2
    print_for2End:

    li $v0,11
    li $a0,newline
    syscall

    addi $t0,1
    j print_for1
  print_for1End:
  
  li $v0,11
  li $a0,newline
  syscall

  jr $ra 




# Desarrolla la funcion paso
# ESPECIFICA AQUI LOS ARGUMENTOS DE ENTRADA Y SALIDA COMO COMENTARIOS
#Argumentos
#$a0 <- direccion de matriz 
#$a1 <- num de filas (igual que el de columnas)
#$a2 <- fila actual [1,nFilas]
#$a3 <- columna actual [1,nColumnas]


#Retorna
#$v0 <- fila
#$v1 <- columna

#Variables locales
#$s0 <- direccion de matriz 
#$s1 <- num de filas (igual que el de columnas)
#$s2 <- fila actual [1,nFilas] i
#$s3 <- columna actual [1,nColumnas] j

#$s4 <- solved
#$s5 <- i o j (aux)

paso:	

  addi $sp,$sp,-28
  sw $s0,0($sp)
  sw $s1,4($sp)
  sw $s2,8($sp)
  sw $s3,12($sp)
  sw $s4,16($sp)
  sw $s5,20($sp)
  sw $ra,24($sp)
  
  move $s0,$a0
  move $s1,$a1
  move $s2,$a2
  move $s3,$a3

  addi $s2,-1 #i--
  addi $s3,-1 #j--

  
  move $s4,$zero

  #up
  move $t0,$s2
  addi $t0,-1

  blt $t0,$zero,left
    addi $s2,-1
    move $a0,$s2
    move $a1,$s3
    lw $a2,size
    move $a3,$s1
    jal calc_desp

    add $v0,$v0,$s0

    lb $v0,0($v0)
    li $t0,libre
    
    bne $v0,$t0,left
      move $v0,$s2
      addi $v0,1
      move $v1,$s3
      add $v1,1
      li $s4,1

  left:
  
  bne $s4,$zero,paso_end






paso_end:

  lw $s0,0($sp)
  lw $s1,4($sp)
  lw $s2,8($sp)
  lw $s3,12($sp)
  lw $s4,16($sp)
  lw $s5,20($sp)
  lw $ra,24($sp)
  addi $sp,$sp,28


  jr $ra 


#Calcula desplazamiento
#Argumentos
#$a0 <- i
#$a1 <- j
#$a2 <- nColumnas
#$a3 <- size

#Retorna 
#$v0 <- posicion de memoria 

#i--, j--
#desplazamiento = (size * ncols * i) + (j * size)
#desplazamiento = size * (ncols * i + j)

calc_desp:

  move $v0,$a2
  mul $v0,$v0,$a0
  add $v0,$v0,$a1
  mul $v0,$v0,$a3

  jr $ra


	
	
# Desarrolla la funcion recorre_camino
# ESPECIFICA AQUI LOS ARGUMENTOS DE ENTRADA Y SALIDA COMO COMENTARIOS
recorre_camino:
	

# Desarrolla aqui el CUERPO PRINCIPAL DEL PROGRAMA				
main:
	
		
  #Imprime matriz 
  la $a1,laberinto
  li $a2,lado
  jal print_matriz

  #Paso
  la $a0,laberinto
  li $a1,lado
  li $a2,2
  li $a3,1
  jal paso

  li $v0,10
  syscall



