#Laboratory Exercise 4, Assignment 5

.text
	addi $s1, $zero, 24
	addi $s2, $zero, 8
	
	srl $s2, $s2, 1
	sllv $s3, $s1, $s2 	#s3 = s1 * s2
	
	li $v0, 1
	add $a0, $zero, $s3
	syscall