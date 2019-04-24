#Laboratory Exercise 7, Assignment 3
.data
Message1: .asciiz "The first popped element : "
Message2: .asciiz "The second popped element : "
Message3: .asciiz "The third popped element : "
.text
	li 	$s0, 24
	li 	$s1, 9
	li 	$s2, 31
push:
	addi 	$sp, $sp, -12		# adjust stack pointer before pushing
	sw 	$s0, 8($sp)
	sw 	$s1, 4($sp)
	sw 	$s2, 0($sp)
pop:
	lw 	$t0, 0($sp)
	lw 	$t1, 4($sp)
	lw 	$t2, 8($sp)
	addi 	$sp, $sp, 12		# adjust stack pointer after popping
display:
	li 	$v0, 56
	la 	$a0, Message1
	la 	$a1, 0($t0)
	syscall
	la 	$a0, Message2
	la 	$a1, 0($t1)
	syscall
	la 	$a0, Message3
	la 	$a1, 0($t2)
	syscall
	li 	$v0, 10
	syscall
end: