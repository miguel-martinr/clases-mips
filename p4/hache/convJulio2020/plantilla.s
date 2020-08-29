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
			      .ascii "#0##00#"
			      .ascii "#0###0#"
			      .ascii "#00000#"
			
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

  

  #up  i-1,j
  move $t0,$s2 #$t0 = i
  addi $t0,-1  #$t0_= i - 1

  blt $t0,$zero,left #if (i - 1) < 0 then j left
    move $a0,$t0 #$a0 = i-1
    move $a1,$s3 #$a1 = j
    move $a2,$s1 #$a2 = nCols
    lw $a3,size  #$a3 = size
    jal calc_desp

    add $v0,$v0,$s0 #$v0 = &mat[i-1][j]

    lb $v0,0($v0) #$v0 = mat[i-1][j]
    li $t1,libre #$t1 = '0'
    
    bne $v0,$t1,left #if mat[i-1][j] != '0' then j left
      move $v0,$t0 #$v0 = i-1
      move $v1,$s3 #$v0 = j
      j paso_end

  #left i,j-1
  left:
    move $t0,$s3 #$t0 = j
    addi $t0,-1 #$t0 = j - 1
    blt $t0,$zero,right #if (j-1) < 0 then j right
      move $a0,$s2 #$a0 = i
      move $a1,$t0 #$a1 = j-1
      move $a2,$s1 #$a2 = nCols
      lw $a3,size
      jal calc_desp
      add $v0,$v0,$s0 # $v0 = &mat[i][j-1]
      lb $v0,0($v0) #$v0 = mat[i][j-1]
      li $t1,libre #$t1 = '0'

      bne $v0,$t1,right
        move $v0,$s2 #$v0 = i
        move $v1,$t0 #$v1 = j-1
        j paso_end

  #right i,j+1
  right:
    move $t0,$s3 #$t0 = j
    addi $t0,1 #$t0 = j + 1
    bge $t0,$s1,down #if (j+1) >= nCols then j down
      move $a0,$s2 #$a0 = i
      move $a1,$t0 #$a1 = j+1
      move $a2,$s1 #$a2 = nCols
      lw $a3,size
      jal calc_desp
      add $v0,$v0,$s0 # $v0 = &mat[i][j+1]
      lb $v0,0($v0) #$v0 = mat[i][j+1]
      li $t1,libre #$t1 = '0'

      bne $v0,$t1,down
        move $v0,$s2 #$v0 = i
        move $v1,$t0 #$v1 = j+1
        j paso_end


  #down i+1,j
  down:
    move $t0,$s2 #$t0 = i
    addi $t0,1  #$t0_= i + 1

    bge $t0,$s1,paso_end #if (i + 1) >= nCols then j paso_end
      move $a0,$t0 #$a0 = i+1
      move $a1,$s3 #$a1 = j
      move $a2,$s1 #$a2 = nCols
      lw $a3,size  #$a3 = size
      jal calc_desp

      add $v0,$v0,$s0 #$v0 = &mat[i+1][j]

      lb $v0,0($v0) #$v0 = mat[i+1][j]
      li $t1,libre #$t1 = '0'
      
      bne $v0,$t1,paso_end #if mat[i+1][j] != '0' then j left
        move $v0,$t0 #$v0 = i+1
        move $v1,$s3 #$v0 = j
        j paso_end

paso_end:


  move $s2,$v0
  move $s3,$v1
  
  move $a0,$v0
  move $a1,$v1
  move $a2,$s1
  lw $a3,size
  jal calc_desp

  add $v0,$v0,$s0
  li $s0,88
  sb $s0,0($v0)

  move $v0,$s2
  move $v1,$s3
  addi $v0,1
  addi $v1,1


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
#Argumentos
#$a0 <- dir matriz
#$a1 <- nFilas
#$f12 <- costeH
#$f14 <- costeV
#Retorna
#$f0 <- costeTotal

#Variables locales
#$s0 <- dir matriz
#$s1 <- nFilas
#$f20 <- costeH
#$f22 <- costeV
#$f24 <- costeTotal
#$s2 <- oldPos[0]
#$s3 <- oldPos[1]
#$s4 <- newPos[0]
#$s5 <- newPos[1]

recorre_camino:
  
  addi $sp,-52
  sw $s0,0($sp)
  sw $s1,4($sp)
  s.d $f20,8($sp)
  s.d $f22,16($sp)
  sw $s2,24($sp)
  sw $s3,28($sp)
  sw $s4,32($sp)
  sw $s5,36($sp)
  s.d $f24,40($sp)
  sw $ra,48($sp)

#Variables locales
#$s0 <- dir matriz
#$s1 <- nFilas
#$f20 <- costeH
#$f22 <- costeV
#$f24 <- costeTotal
#$s2 <- oldPos[0]
#$s3 <- oldPos[1]
#$s4 <- newPos[0]
#$s5 <- newPos[1]

  move $s0,$a0 #dirMatriz
  move $s1,$a1 #nFilas

  mov.d $f20,$f12 #costeH
  mov.d $f22,$f14 #costeV

  li.d $f24,0.0

  

  li $a0,0
  li $a1,0
  move $a2,$s1
  lw $a3,size
  jal calc_desp

  add $v0,$v0,$s0
  li $t0,88
  sb $t0,0($v0) #mat[0][0] = 'X'

  li $s4,1
  li $s5,1 #newPos = 1,1
  
  recorre_do:
    move $s2,$s4
    move $s3,$s5 #oldPos = newPos

    move $a0,$s0
    move $a1,$s1
    move $a2,$s2
    move $a3,$s3
    jal paso

    move $s4,$v0
    move $s5,$v1

    beq $s2,$s4,notV
      add.d $f24,$f24,$f22
    notV:

    beq $s3,$s5,notH
      add.d $f24,$f24,$f20
    notH:

    la $a1,laberinto
    li $a2,lado
    jal print_matriz

  blt $s5,$s1,recorre_do


  mov.d $f0,$f24
  


  lw $s0,0($sp)
  lw $s1,4($sp)
  l.d $f20,8($sp)
  l.d $f22,16($sp)
  lw $s2,24($sp)
  lw $s3,28($sp)
  lw $s4,32($sp)
  lw $s5,36($sp)
  l.d $f24,40($sp)
  lw $ra,48($sp)
  addi $sp,-52



#Variables locales
#$s0 <- dir matriz
#$s1 <- nFilas
#$f20 <- costeH
#$f22 <- costeV
#$f24 <- costeTotal
#$s2 <- oldPos[0]
#$s3 <- oldPos[1]
#$s4 <- newPos[0]
#$s5 <- newPos[1]
  jr $ra

# Desarrolla aqui el CUERPO PRINCIPAL DEL PROGRAMA				
main:
	
		
  #Imprime matriz 
  la $a1,laberinto
  li $a2,lado
  jal print_matriz

  #Argumentos
#$a0 <- dir matriz
#$a1 <- nFilas
#$f12 <- costeH
#$f14 <- costeV
#Retorna
#$f20 <- costeTotal

  la $a0,laberinto
  li $a1,lado
  li.d $f12,1.0
  li.d $f14,1.0
  jal recorre_camino

  la $a1,laberinto
  li $a2,lado
  jal print_matriz

  li $v0,10
  syscall



