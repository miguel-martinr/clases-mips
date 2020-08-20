# Universidad de La Laguna
# Ingenieria Informatica - Principios de Computadores
# Practica 5
# Programa que pide una cadena por teclado, la invierte (recursiva  e iterativamente)
# e indica si es palíndroma.
#
#
# Autor: Miguel Martin
# e-mail: alu0101209777@ull.edu.es
# Fecha creación: 20200510

.data
cadena:   	.asciiz "Practica 5 de Principios de Computadores. Quedate en casa!!\n\nPrograma que pide una cadena por teclado, la invierte (recursiva  e iterativamente) e indica si es palíndroma.\n"
cadena2:	  .asciiz "roma tibi subito m otibus ibit amor"
cadtiene:	  .asciiz " tiene "
cadcarac:	  .asciiz " caracteres.\n"
cadespal:	  .asciiz "Es palíndroma.\n\n"
cadnoespal:	.asciiz "No es palíndroma.\n\n"
cadpedir:   .asciiz "\nIntroduzca una cadena. [MAX 200 caracteres]: "
salto:      .asciiz "\n"
recursiva:  .asciiz "\nFuncion recursiva: "
iterativa:  .asciiz "\nFuncion iterativa: "



rotor:      .asciiz "rotor"
pera:       .asciiz "pera"
sopas:      .asciiz "sopas y sapos"
mono:       .asciiz "m"

	.text

strlen:
# numero de caracteres que tiene una cadena sin considerar el '\0'
# la cadena tiene que estar terminada en '\0'
# $a0 tiene la direccion de la cadena
# $v0 devuelve el numero de caracteres
# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN strlen SIN CAMBIAR LOS ARGUMENTOS

  move $v0,$zero
  lb $t0,0($a0)
  whileStrLen:
    beq $t0,$zero,whileStrLenEnd
    addi $v0,1
    addi $a0,1
    lb $t0,0($a0)
    j whileStrLen
  whileStrLenEnd:

  jr $ra


reverse_r:
# funcion que da la vuelta a una cadena
# $a0 cadena a la que hay que dar la vuelta
# $a1 numero de caracternes que tiene la cadena
# $v0 1 Si es palíndroma 0 si no lo es
#Pseudocodigo
#void reverse_r(char arr[], int iStart, int iLast, bool& pal) {
#  pal = true;
#  return reverse_r_sub(arr, iStart, iLast, pal);
#}
#
#
#
#void reverse_r_sub(char arr[], int iStart, int iLast, bool& pal)
#{
#    if( (iLast - iStart) == 0 || (iLast - iStart) == 1)
#      return;
#
#        //swap
#        char temp = arr[iStart];
#        arr[iStart] = arr[iLast];
#        arr[iLast] = temp;
#
#        reverse_r_sub(arr, ++iStart, --iLast, pal);
#
#}

# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN reverse_i SIN CAMBIAR LOS ARGUMENTOS

li $v0,1                             # Partimos de que es palindromo

reverse_r_sub:
beq $a1,$zero,reverse_r_end          # Si size == 0 return
li $t1,1
beq $a1,$t1,reverse_r_end            # Si size == 1 return

addi $sp,-4
sw $ra,0($sp)                               #Guardamos dir de retorno

addi $a1,-1                                 #size-1 (posicion ultimo byte)
lb $t0,0($a0)                               #$t0 = primer byte
add $t2,$a0,$a1
lb $t1,0($t2)                               #$t1 = ultimo byte

beq $t0,$t1,is_pal                          #Si bytes diferentes en un swap = no pal
li $v0,0
is_pal:

sb $t0,0($t2)
sb $t1,0($a0)

addi $a0,1
addi $a1,-1
jal reverse_r_sub                           #reverse(++first,--last)

lw $ra,0($sp)
addi $sp,4
reverse_r_end:

jr $ra




reverse_i:
# funcion que da la vuelta a una cadena
# $a0 cadena a la que hay que dar la vuelta
# $a1 numero de caracternes que tiene la cadena
# $v0 1 Si es palíndroma 0 si no lo es
#Pseudocodigo
#
# for (i = 0, j = size-1; i < sizeCadena/2; i++, j--) hacer
#   swap(cadena[i],cadena[j])
#   si cadena[i] != cadena [j]
#     pal = false;
#
#
# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN reverse_r SIN CAMBIAR LOS ARGUMENTOS

  beq $a1,$zero,end_reverse_i
  li $t0,1
  beq $a1,$t0,end_reverse_i

  li $v0,2
  div $t0,$a1,$v0               #$t0 = size/2

  li $v0,1                      #Partimos de que es palíndroma

  move $t1,$a0
  add $t1,$t1,$a1
  addi $t1,-1                   #$t1 = dir de último caracter

  li $t2,0                      #$t2 = contador
  bucle_reverse:
    bge $t2,$t0,end_bucle_reverse
    lb $t3,0($a0)
    lb $t4,0($t1)
    beq $t3,$t4,es_pal_i
      li $v0,0
  es_pal_i:

    #Intercambio
    sb $t3,0($t1)
    sb $t4,0($a0)


    addi $a0,1
    addi $t1,-1
    addi $t2,1
    j bucle_reverse

  end_bucle_reverse:
    jr $ra

  end_reverse_i:
  li $v0,1
  jr $ra


print:
#Función que imprime la cadena y cuantos caracteres tiene
#$a0 Posición donde empieza la cadena
#$a1 Nº de caracteres
  li $v0,4
  syscall

  la $a0,cadtiene
  syscall

  li $v0,1
  move $a0,$a1
  syscall

  li $v0,4
  la $a0,cadcarac
  syscall

  jr $ra







main:
			# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN main QUE REPRODUZCA LA SALIDA COMO EL GUIÓN
			# INVOCANDO A LA FUNCIÓN strlen DESPUÉS DE CADA MODIFICACIÓN DE LAS CADENAS

#Imprimimos intro
li $v0,4
la $a0,cadena
syscall


#Pedimos cadena por teclado
li $v0,4
la $a0,cadpedir
syscall

li $v0,9                        #Reservamos espacio para la cadena
li $a0,201
syscall

move $s0,$v0                    #$s0 = Dir del buffer

li $v0,8
move $a0,$s0
li $a1,201
syscall

move $a0,$s0
jal strlen
move $s1,$v0                    #Guardamos el tamaño de la cadena

                                #Quitamos el salto de linea que añade la syscall al leer de teclado
move $t0,$s0
addi $s1,-1                     #No queremos que se cuente el caracter \n
add $t0,$t0,$s1
sb $zero,0($t0)


move $a0,$s0
move $a1,$s1
jal print                       #Imprimimos cadena normalmente

                                #Invertimos la cadena (recursivamente)
li $v0,4
la $a0,recursiva
syscall

move $a0,$s0
move $a1,$s1
jal reverse_r

move $s2,$v0

move $a0,$s0
move $a1,$s1
jal print

li $v0,4
la $a0,cadnoespal
beq $s2,$zero,noes_palR
  la $a0,cadespal
noes_palR:
syscall

                                #Invertimos la cadena de nuevo (iterativamente)
li $v0,4
la $a0,iterativa
syscall

move $a0,$s0
move $a1,$s1
jal reverse_i

move $s2,$v0

move $a0,$s0
move $a1,$s1
jal print

li $v0,4
la $a0,cadnoespal
beq $s2,$zero,noes_palI
  la $a0,cadespal
noes_palI:
syscall



  li $v0,10
  syscall
