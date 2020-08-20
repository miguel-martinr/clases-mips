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
		 
reverse_i:  # funcion que da la vuelta a una cadena
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracternes que tiene la cadena
			# $v0 1 Si es palindroma 0 si no lo es
			
			# INTRODUCE AQUI EL CODIGO DE LA FUNCION reverse_i SIN CAMBIAR LOS ARGUMENTOS

reverse_r:  
      # funcion que da la vuelta a una cadena
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracternes que tiene la cadena
			# $v0 1 Si es palindroma 0 si no lo es
			
			# INTRODUCE AQUI EL CODIGO DE LA FUNCION reverse_r SIN CAMBIAR LOS ARGUMENTOS
  
   #Prologo: guardamos en la pila las cosas que necesitamos
   addi $sp,-4
   sw $ra,0($sp)





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
# la $a0,cadena
# jal strlen

# Ahora en $v0 deberia estar la longitud de: cadena

 #Imprimimos la longitud
 li $v0,1
 move $a0,$v0
 syscall

 #Imprimimos la cadena: cadcaracteres
 li $v0,4
 la $a0,cadcarac
 syscall



  li $v0,10
  syscall