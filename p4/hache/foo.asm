#Creado en 20200812
.data

menu: .asciiz  "\nElija una opcion.."
inFilas:  .asciiz "\nFilas >"
inCols:  .asciiz "\nColumnas >"

inDato:  .asciiz "\nDato >"

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



























li $v0,10
syscall


# do1:

#   move $t0,$zroe

#   for1:
#     bge $t0,$s1,for1End

#     move $t1,$zero
#     for2:
#       bge $t1,$s2,for2End




#       addi $t1,1
#       j for2
#     for2End:


#     addi $t0,1
#     j for1
#   for1End:



#   bne $s0,$zero,do1
# do1End:
