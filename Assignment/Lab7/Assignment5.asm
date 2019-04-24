#Laboratory Exercise 7, Assignment 5
.data
Message1: 	.asciiz "The largest value is "
storeAt: 	.asciiz " stored at register $s"
Message2: 	.asciiz "\nThe smallest value is "
array: .
.text
input_value:
	addi 	$s0, $zero, 24
	addi 	$s1, $zero, 5
	addi 	$s2, $zero, -3
	addi 	$s3, $zero, 9
	addi 	$s4, $zero, -1
	addi 	$s5, $zero, 31
	addi 	$s6, $zero, -6
	addi 	$s7, $zero, 2
main:
	jal 	WRAP
print_out:
#largest
	li 	$v0, 4
	la 	$a0, Message1 
	syscall
	li 	$v0, 1
	la 	$a0, 0($a2)
	syscall
	li 	$v0, 4
	la 	$a0, storeAt
	syscall
	li 	$v0, 1
	la 	$a0, 0($t0)
	syscall
#smallest
	li 	$v0, 4
	la 	$a0, Message2 
	syscall
	li 	$v0, 1
	la 	$a0, 0($a3)
	syscall
	li 	$v0, 4
	la 	$a0, storeAt 
	syscall
	li 	$v0, 1
	la 	$a0, 0($t1)
	syscall
quit:
	li 	$v0, 10
	syscall
end_main:

#===============================================================================
#Procedure WRAP
#t0 for the max register
#a2 for the max value
#t1 for the min register
#a3 for the min value
#===============================================================================

WRAP:
	sw 	$fp, -4($sp)		# save frame pointer
	addi 	$fp, $sp, 0		# new frame pointer to the top
	addi 	$sp, $sp, -8 		# adjust stack pointer
	sw 	$ra, 0($sp)   		# save main return address
	
	jal 	find_max_min
	nop
	
	lw 	$ra, 4($sp)		# restore return address
	addi 	$sp, $fp, 0		# restore stack pointer
	lw 	$fp, -4($sp)		# restore frame pointer
	jr 	$ra			# jump to calling
WRAP_END:

#procedure find max min
find_max_min:
push_into_stack:
	addi 	$sp, $sp, -32 		# adjust stack
	sw 	$s0, 28($sp)
	sw 	$s1, 24($sp)
	sw 	$s2, 20($sp)
	sw 	$s3, 16($sp)
	sw  	$s4, 12($sp)
	sw 	$s5, 8($sp)
	sw 	$s6, 4($sp)
	sw 	$s7, 0($sp)
init:	
	addi 	$t2, $zero, 7		# init counting index
	lw 	$a2, 0($sp)		# pop up the above element as the max value
	lw 	$a3, 0($sp) 		# pop up the above element as the min value
finding:
	addi 	$t2, $t2, -1	 	# index--
	blt 	$t2, $zero, done_finding

	addi 	$sp, $sp, 4		# move to the next element
	lw 	$t3, 0($sp)		# t3: temporary var, load value of element index t2
	blt 	$a2, $t3, set_new_max
	nop
	blt 	$t3, $a3, set_new_min
	nop
	j 	set_done
set_new_max:
	addi 	$a2, $t3, 0
	addi 	$t0, $t2, 0
	j 	set_done
set_new_min:
	addi 	$a3, $t3, 0
	addi 	$t1, $t2, 0
set_done:
	j 	finding
done_finding:	
	jr 	$ra			# jump to calling find_max_min in WRAP