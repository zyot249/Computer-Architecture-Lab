#Laboratory Exercise 5, Assignment 2
.data
	message1:	.asciiz	"The sum of "
	message2:	.asciiz	" and "
	message3:	.asciiz	" is "
.text
	addi	$s0, $zero, 6
	addi	$s1, $zero, 5
	add	$s3, $s1, $s0
	
	li	$v0, 4
	la	$a0, message1
	syscall
	
	li	$v0, 1
	add	$a0, $zero, $s0
	syscall
	
	li	$v0, 4
	la	$a0, message2
	syscall
	
	li	$v0, 1
	add	$a0, $zero, $s1
	syscall
	
	li	$v0, 4
	la	$a0, message3
	syscall
	
	li	$v0, 1
	add	$a0, $zero, $s3
	syscall