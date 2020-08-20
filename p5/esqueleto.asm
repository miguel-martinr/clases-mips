	.data
cadena: 	.asciiz "Practica 5 de Principios de Computadores. Quedate en casa!!"
cadena2:	.asciiz "roma tibi subito m otibus ibit amor"
cadtiene:	.asciiz " tiene "
cadcarac:	.asciiz " caracteres.\n"
cadespal:	.asciiz "Es palíndroma.\n\n"
cadnoespal:	.asciiz "No es palíndroma.\n\n"
instr:  .asciiz " > "
	.text

strlen:  # numero de caracteres que tiene una cadena sin considerar el '\0'
		 # la cadena tiene que estar terminada en '\0'
		 # $a0 tiene la direccion de la cadena
		 # $v0 devuelve el numero de caracteres
     
     #  int cont = 0;
     #  while (ptr != '\0')
     #    cont++, ptr++
     #  return cont;

       move $v0,$zero
       lb $t0,0($a0)
       strlen_Do:
       beq $t0,$zero,strlen_endDo
        addi $v0,1
        addi $a0,1
        lb $t0,0($a0)
        j strlen_Do
       strlen_endDo:

       addi $a0,-1
       sb $zero,0($a0)
       addi $v0,-1

       jr $ra

       
		 # INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN strlen SIN CAMBIAR LOS ARGUMENTOS
		 
reverse_i:  # funcion que da la vuelta a una cadena
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracternes que tiene la cadena
			# $v0 1 Si es palíndroma 0 si no lo es
			
			# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN reverse_i SIN CAMBIAR LOS ARGUMENTOS
				

reverse_r:  # funcion que da la vuelta a una cadena
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracternes que tiene la cadena
			# $v0 1 Si es palíndroma 0 si no lo es
			li $v0,1
      reverse_rr:

        addi $sp,-4
        sw $ra,0($sp)


        beq $a1,$zero,reverse_rr_end
        li $t0,1
        beq $a1,$t0,reverse_rr_end

        addi $a1,-1 #--length

        lb $t0,0($a0) # $t0(aux) = *str_
        
        add $t2,$a0,$a1 
        lb $t1,0($t2) # $t1 = *(str_ + length)
        sb $t1,0($a0) # *str_ = *(str_ + length)

        beq $t0,$t1,is_pal
          move $v0,$zero
        is_pal:

        sb $t0,0($t2) # *(str_ + length) = aux

        addi $a0,1
        addi $a1,-1
        jal reverse_rr

      reverse_rr_end:
        lw $ra,0($sp)
        addi $sp,4

      jr $ra

			# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN reverse_r SIN CAMBIAR LOS ARGUMENTOS
				

main:
			# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN main QUE REPRODUZCA LA SALIDA COMO EL GUIÓN
			# INVOCANDO A LA FUNCIÓN strlen DESPUÉS DE CADA MODIFICACIÓN DE LAS CADENAS
			
      li $v0,9
      li $a0,50
      syscall
      move $s0,$v0
      

      #cout << " > "
      li $v0,4
      la $a0,instr
      syscall
      
      #cin >> str
      li $v0,8
      move $a0,$s0
      li $a1,51
      syscall

      move $a0,$s0
      jal strlen

      move $a0,$v0
      move $s1,$v0
      li $v0,1
      syscall

      move $a0,$s0
      move $a1,$s1
      jal reverse_rr

			li $v0,10
      syscall