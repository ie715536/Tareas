.data

.text

main:
	addi $t0, $zero, 6 #valor de n
	subi $a0, $t0, 0 #almaceno n
	subi $a1, $a0, 1 #almaceno n-1
	beq $t0, 0, cero
	beq $t0, 1, uno

	sw $a0 0($sp) #reservo memoria para n
	sw $a1 4($sp) #reservo memoria para n-1
	sw $ra 8($sp) #guardo la dirección de retorno
	jal Fubonacci #primer salto de registro 
	j exit

loop:
	#if a0 > 1
	blt $a0, 2, loop2
	jal Fubonacci
	
	addi $sp, $sp, 12 #Me muevo al espacio reservado en memoria
	lw $a0 0($sp) #tomo n del dato reservado de memoria
	lw $a1 4($sp) #tomo el daton-1 reservado de memoria
	lw $ra 8($sp) #tomo la dirección de retorno
	
	j loop3
loop2:	#else 
	add $v0, $v0, $a0 #sumo el n cuando es 1
loop3:	
	#if a1 > 1
	blt $a1, 2, loop4
	subi $a0, $a0, 2 #guardo los datos de n-1 como un nuevo n
	subi $a1, $a0, 1 #es el nuevo n-1 del nuevo n generado
	sw $a0 0($sp)    #reservo memoria para n
	sw $a1 4($sp)	#reservo memoria para n-1
	j loop
loop4:	#else
	add $v0, $v0, $a1 #sumo el valor de n-1 cuando es 0 ó 1
	jr $ra 

Fubonacci:
	subi $a0, $a0, 1  #le resta 1 a n
	subi $a1, $a0, 1  #le resta 2 a n
	addi $sp, $sp, -12 #reservo memoria para el n-1 y el n-2 formado
	sw $a0 0($sp) #guardo lo que sería el nuevo n (n-1)
	sw $a1 4($sp) #guardo lo que sería el nuevo n-1 (n-2)
	sw $ra 8($sp) #guardo el valor de retorno
	j loop
	
uno:
	addi $v0, $zero, 1
cero:
	addi $v0, $zero, 0
exit:
