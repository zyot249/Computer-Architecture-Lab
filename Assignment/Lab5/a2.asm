#Laboratory Exercise 5, Home Assignment 2
.data
	x: .space 1000
	y: .asciiz "Noi voi em rang"
	
.text
	la $a1, y
	la $a0, x
	strcpy:
		add $s0, $zero, $zero		# s0 = i = 0
	L1:
		add $t1, $s0, $a1		# t1 = s0 + a1 = i + y[0]
		lb $t2, 0($t1)			# t2 = y[i]
		add $t3, $s0, $a0		# t3 = s0 + a0 = i + x[0]
		sb $t2, 0($t3)
		beq $t2, $zero, end_of_strcpy
		nop
		addi $s0, $s0, 1
		j	L1
		nop
	end_of_strcpy:
	addi $a1, $zero, 0
	addi $a0, $zero, 0
	li $v0, 4
	la $a0, x
	syscall
		