# Programa que cuenta el nro de veces que aparece una cifra en un nro entero 
# positivo

.data

str1:  .asciiz  "Encuentra el numero de veces que aparece una cifra en un entero.\n\n"
str2:  .asciiz  "Introduzca la cifra a buscar (numero de 0 a 9) > "
str3:  .asciiz  "Introduzca un entero positivo donde se realizara la busqueda > "

buscando:  .asciiz  "Buscando "
en:        .asciiz  " en "
puntos:    .asciiz  " ...\n\n";

str4:  .asciiz  "La cifra buscada se encontro en "
str5:  .asciiz  " ocasiones.\n\n"

.text


  main:

    #Print title
    li $v0,4
    la $a0,str1
    syscall


    #int cifra;
    # do {
    #     std::cout << "Introduzca la cifra a buscar (numero de 0 a 9): ";
    #     std::cin >> cifra;
    # } while ((cifra < 0) || (cifra > 9));

    #First do while
    # $s0 === cifra
    do1:
      li $v0,4
      la $a0,str2 
      syscall

      li $v0,5
      syscall 

      blt $v0,$zero,do1
      li $t0,9
      bgt $v0,$t0,do1
    move $s0,$v0


    #int numero;
    #do {
    #    std::cout << "Introduzca un entero positivo donde se realizara la búsqueda: ";
    #    std::cin >> numero;
    #} while (numero < 0);

    #Second do while
    # $s1 === numero    
    do2:
      li $v0,4
      la $a0,str3
      syscall 

      li $v0,5
      syscall 

      blt $v0,$zero,do2 
    move $s1,$v0


    #std::cout << "Buscando " << cifra << " en " << numero << " ... " << std::endl;

    li $v0,4
    la $a0,buscando
    syscall 
    
    li $v0,1
    move $a0,$s0 
    syscall

    li $v0,4
    la $a0,en
    syscall 

    li $v0,1
    move $a0,$s1
    syscall 

    li $v0,4
    la $a0,puntos
    syscall 

    #int encontrado = 0;
    #do {
    #    int resto = numero % 10;
    #    if (resto == cifra) encontrado++;
    #    numero = numero / 10;
    #} while (numero != 0);

    #Third do while
    #$s2 === encontrado
    #$t0 === resto
    move $s2,$zero
    do3:
      li $t1,10
      div $s1,$t1
      mfhi $t0 

      bne $t0,$s0,notEqual
        addi $s2,1
      notEqual: 
      
      mflo $s1 

      bne $s1,$zero,do3 

    #std::cout << "La cifra buscada se encontro en " << encontrado <<" ocasiones." << std::endl;
    li $v0,4
    la $a0,str4
    syscall

    li $v0,1
    move $a0,$s2
    syscall 

    li $v0,4
    la $a0,str5
    syscall 







    li $v0,10
    syscall