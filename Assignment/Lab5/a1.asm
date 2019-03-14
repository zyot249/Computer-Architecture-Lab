#Laboratory Exercise 5, Home Assignment 1
.data
	test: .asciiz "Hello Shynnnnnn"
.text
	li $v0, 4
	la $a0, test
	syscall