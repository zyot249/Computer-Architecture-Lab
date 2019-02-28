#Laboratory Exercise 3, Home Assignment 3
.data
	test: 	.word 1
	a:	.word 5
	b:	.word 2
.text
		la $t8, a
		lw $s2, 0($t8)
		la $t9, b
		lw $s3, 0($t9)
		la $s0, test	#load the address of test variable
		lw $s1, 0($s0) 	#load the value of test to register $t1
		li $t0, 0 	#load value for test case
		li $t1, 1
		li $t2, 2
		beq $s1, $t0, case_0
		beq $s1, $t1, case_1
		beq $s1, $t2, case_2
		j default
case_0: 	addi $s2, $s2, 1	#a=a+1
		j continue
case_1: 	sub $s2, $s2, $t1 	#a=a-1
		j continue
case_2: 	add $s3, $s3, $s3 	#b=2*b
		j continue
default: 
continue:
