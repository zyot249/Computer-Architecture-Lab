#Laboratory Exercise 5, Assignment 5
.data
	string:		.space	20
	reverse:	.space	20
	message:	.asciiz	"The reverse string is: "
.text
	get_string:
		li	$v0, 8	#read string
		la	$a0, string
		la	$a1, 20
		syscall
	get_length: 
		la	$a0, string
		xor	$v0, $zero, $zero	#v0 = length
		xor	$t0, $zero, $zero	# t0 = i
		addi	$a3, $zero, 0x0a	# a3 = \n
	check_char:
		add	$t1, $a0, $t0		# t1 = string[i]
		lb	$t2, 0($t1)
		beq	$t2, $a3, end_of_str	# if t2 = t2 = string[i] == \n --> end 
		beq	$t2, $zero, end_of_str	# if string[i] == null --> end
		add 	$v0, $v0, 1
		add	$t0, $t0, 1
		j	check_char
	end_of_str:
	end_of_get_length:
	
	
	la $a1, string
	la $a0, reverse
	strcpy:
		addi $s0, $v0, -1		# s0 = i = length
		add $s1, $zero, $zero		# s1 = j = 0
	L1:
		bltz $s0, end_of_strcpy		# if i < 0 --> end
		add $t1, $s0, $a1		# t1 = s0 + a1 = i + string[0]
		lb $t2, 0($t1)			# t2 = string[i]
		add $t3, $s1, $a0		# t3 = s0 + a0 = j + reverse[0]
		sb $t2, 0($t3)
		beq $t2, $zero, end_of_strcpy	# if string[i] == null --> end
		nop
		addi $s0, $s0, -1
		addi $s1, $s1, 1
		j	L1
		nop
	end_of_strcpy:
	addi $a1, $zero, 0
	addi $a0, $zero, 0
	
	li $v0, 4	# print string
	la $a0, message
	syscall
	
	li $v0, 4
	la $a0, reverse
	syscall
