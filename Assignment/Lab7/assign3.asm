#Laboratory exercise 7, assignment 3
.data
Mess1: .asciiz "The first popped element : "
Mess2: .asciiz "The second popped element : "
Mess3: .asciiz "The third popped element : "
.text
	li $s0,5
	li $s1,10
	li $s2,69
push:
	addi $sp,$sp,-12	#adjust stack pointer before pushing
	sw $s0,8($sp)
	sw $s1,4($sp)
	sw $s2,0($sp)
pop:
	lw $t0,0($sp)
	lw $t1,4($sp)
	lw $t2,8($sp)
	addi $sp,$sp,12		#adjust stack pointer after popping
display:
	li $v0,56
	la $a0,Mess1
	la $a1,0($t0)
	syscall
	la $a0,Mess2
	la $a1,0($t1)
	syscall
	la $a0,Mess3
	la $a1,0($t2)
	syscall
	li $v0,10
	syscall
end:
	
	
	
	 
	 
	
