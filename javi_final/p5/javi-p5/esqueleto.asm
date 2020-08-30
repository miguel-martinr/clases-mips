	.data
cadena: 	.asciiz "Practica 5 de Principios de Computadores. Quedate en casa!!"
cadena2:	.asciiz "roma tibi subito m otibus ibit amor"
cadtiene:	.asciiz " tiene "
cadcarac:	.asciiz " caracteres.\n"
cadespal:	.asciiz "Es palindroma.\n\n"
cadnoespal:	.asciiz "No es palindroma.\n\n"
	.text

strlen:  # numero de caracteres que tiene una cadena sin considerar el '\0'
		 # la cadena tiene que estar terminada en '\0'
		 # $a0 tiene la direccion de la cadena
		 # $v0 devuelve el numero de caracteres

		 # INTRODUCE AQUI EL CODIGO DE LA FUNCION strlen SIN CAMBIAR LOS ARGUMENTOS
		 
       move $v0,$zero

       lb $t0,0($a0)

       strlen_Do:
       beq $t0,$zero,strlen_endDo
        addi $v0,1
        addi $a0,1
        lb $t0,0($a0)
        j strlen_Do
       strlen_endDo:
       

      #  addi $a0,-1
      #  sb $zero,0($a0)
      #  addi $v0,-1

       jr $ra


reverse_i:  # funcion que da la vuelta a una cadena
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracternes que tiene la cadena
			# $v0 1 Si es palindroma 0 si no lo es
			
			# INTRODUCE AQUI EL CODIGO DE LA FUNCION reverse_i SIN CAMBIAR LOS ARGUMENTOS


#Invierte cadena recursiv
#Argumentos
#$a0 <- direccion cadena
#$a1 <- longitud de cadena
#$a2 <- es_pal (bool)
#Retorna
#$v0 <- es_pal (bool)

reverse_rr:

  #prologo
  addi $sp,-4
  sw $ra,0($sp)



  #Caso base
  beq $a1,$zero,reverse_rr_end
  li $t0,1
  beq $a1,$t0,reverse_rr_end


  addi $a1,-1

  #$t0 <- aux
  lb $t0,0($a0)


  #$t1 = str + length
  add $t1,$a0,$a1 


  lb $t2,0($t1)
  sb $t2,0($a0)



  beq $t0,$a0,reverse_rr_notPal
    move $v0,$zero 
  reverse_rr_notPal:


  sb $t0,0($t1)

  addi $a0,1
  addi $a1,-1

  jal reverse_rr


reverse_rr_end:

  #epilogo
  lw $ra,0($sp)
  addi $sp,4

jr $ra 



reverse_r:  
      # funcion que da la vuelta a una cadena
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracternes que tiene la cadena
			# $v0 1 Si es palindroma 0 si no lo es
			
			# INTRODUCE AQUI EL CODIGO DE LA FUNCION reverse_r SIN CAMBIAR LOS ARGUMENTOS
  
   #Prologo: guardamos en la pila las cosas que necesitamos
   addi $sp,-4
   sw $ra,0($sp)

   li $a2,1 #es_pal = true
   jal reverse_rr

  reverse_r_end:

   #Epilogo: deshacemos lo que hicimos en el prologo
   lw $ra,0($sp)
   addi $sp,4

jr $ra







main:
			# INTRODUCE AQUI EL CODIGO DE LA FUNCION main QUE REPRODUZCA LA SALIDA COMO EL GUION
			# INVOCANDO A LA FUNCION strlen DESPUES DE CADA MODIFICACION DE LAS CADENAS
			
  #Imprimir cadena
  li $v0,4
  la $a0,cadena
  syscall

  #Imprimir: cadtiene
  li $v0,4
  la $a0,cadtiene
  syscall




  #Llamar a strlen
  la $a0,cadtiene
  jal strlen

  la $a0,cadtiene
  move $a1,$v0
  jal reverse_r


 

# Ahora en $v0 deberia estar la longitud de: cadena

 #Imprimimos la longitud
 move $a0,$v0
 li $v0,1
 syscall









 #Imprimimos la cadena: cadcaracteres
 li $v0,4
 la $a0,cadcarac
 syscall



  li $v0,10
  syscall