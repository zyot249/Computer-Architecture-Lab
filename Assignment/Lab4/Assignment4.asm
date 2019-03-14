#Laboratory Exercise 4, Assignment 4

.text
	addi $s1, $zero, 100
	addi $s2, $zero, 200
start:
	li $t0, 0		#No overflow
	addu $s3, $s1, $s2	# s3 = s1 + s2
	xor $t1, $s1, $s2	#Test if s1 and s2 have the same sign
	
	bltz $t1, EXIT		#if not, exit
	xor $t2, $s3, $s1
	bltz $t2, OVERFLOW
	j	EXIT
OVERFLOW:
	li $t0, 1		#the result is overflow
EXIT: