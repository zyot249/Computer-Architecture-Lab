# Laboratory Exercise 11, Asssignment 3

.eqv 	IN_ADDRESS_HEXA_KEYBOARD	0xFFFF0012
.eqv 	OUT_ADDRESS_HEXA_KEYBOARD	0xFFFF0014

.data
	Message: 	.asciiz "Key scan code"

.text
Main:
	#---------------------------------------------------------
	# Enable interrupts you expect
	#---------------------------------------------------------
	# Enable the interrupt of Keyboard matrix 4x4 of Digital Lab Sim
	#---------------------------------------------------------
	li 	$t1, IN_ADDRESS_HEXA_KEYBOARD
	li 	$t3, 0x81		# bit 7 = 1 to enable 
	sb 	$t3, 0($t1)
	#---------------------------------------------------------
	# Loop to print a sequence of number
	#---------------------------------------------------------
	xor 	$s0, $s0,$s0		# counter $s0 = 0
Loop:
	addi 	$s0, $s0, 1		# counter++
Print_seq:
	addi 	$v0, $zero, 1
	addi 	$a0, $s0, 0		# print auto sequence numbers
	syscall
Print_eol:
	addi 	$v0, $zero, 11
	li 	$a0, '\n'		# print auto sequence number
	syscall	

Sleep:
	li 	$v0, 32			# sleep for 300ms
	li 	$a0, 300
	syscall
	nop				# WARNING: nop is mandatory here
	b 	Loop
End_main:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# GENERAL INTERRUPT SERVED ROUTINE for all interrupts
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.ktext 	0x80000180
	#--------------------------------------------------------
	# Save the current REG file to stack 
	#--------------------------------------------------------
IntSR:
	addi 	$sp, $sp, 4			# save $ra because we may change it later
	sw 	$ra, 0($sp)
	addi 	$sp, $sp, 4			# save $at because we may change it later
	sw 	$at, 0($sp)
	addi 	$sp, $sp, 4			# save $v0 because we may change it later
	sw 	$v0, 0($sp)
	addi 	$sp, $sp, 4			# save $a0 because we may change it later
	sw 	$a0, 0($sp)	
	addi 	$sp, $sp, 4			# save $t1 because we may change it later
	sw 	$t1, 0($sp)
	addi 	$sp, $sp, 4			# save $t3 because we may change it later
	sw 	$t3, 0($sp)
	
	#--------------------------------------------------------
	# Processing
	#--------------------------------------------------------
	
Print_message:
	li 	$v0, 4
	la 	$a0, Message
	syscall
Get_cod:
	li 	$t1, IN_ADDRESS_HEXA_KEYBOARD
	li 	$t4, 0x82			# check row 2 with key 4, 5, 6, 7 and re-enable bit 7
 	li 	$t5, 0x84			# check row 3 with key 8, 9, A, B and re-enable bit 7
 	li 	$t6, 0x81 			# check row 1 with key 0, 1, 2, 3 and re-enable bit 7
 	li 	$t3, 0x88 			# check row 4 with key C, D, E, F and re-enable bit 7
 	li 	$t2, OUT_ADDRESS_HEXA_KEYBOARD
 	
 	sb 	$t3, 0($t1) 			# must reassign expected row
 	lw 	$t7, ($t2)			# t7 = content of t2
	bne 	$t7, $zero, Print		# if t7 is different from 0, print
	nop
		
	sb 	$t4, 0($t1)			# row 2
	lw 	$t7, ($t2)			# t7 = content of t2
	bne 	$t7, $zero, Print		# if t7 is different from 0, print
	nop
	
	sb 	$t5, 0($t1)			# row 3
	lw 	$t7, ($t2)			# t7 = content of t2
	bne 	$t7, $zero, Print		# if t7 is different from 0, print
	nop
	
	sb 	$t6, 0($t1)			# row 4
	lw 	$t7, ($t2)			# t7 = content of t2
	bne 	$t7, $zero, Print			# if t7 is different from 0, print
	nop
Print:
 	lbu 	$a0, 0($t2)	
Print_cod:
	li 	$v0, 34
	syscall
	li 	$v0, 11
	li 	$a0, '\n'			# print end of line
	syscall
	
Next_pc:
	mfc0 	$at, $14 			# $at <= Coproc0.$14 = Coproc0.epc
	addi 	$at, $at, 4 			# $at = $at + 4 (next instruction)
	mtc0 	$at, $14 			# Coproc0.$14 = Coproc0.epc <= $at
	
	#--------------------------------------------------------
	# Restore REG file from stack
	#--------------------------------------------------------
Restore:
	lw 	$t3, 0($sp)		# Restore registers from stack
	addi 	$sp, $sp, -4
	lw 	$t1, 0($sp)		# Restore registers from stack
	addi 	$sp, $sp, -4
	lw 	$a0, 0($sp)		# Restore registers from stack
	addi 	$sp, $sp, -4
	lw 	$at, 0($sp)		# Restore registers from stack
	addi 	$sp, $sp, -4
	lw 	$ra, 0($sp)		# Restore registers from stack
	addi 	$sp, $sp, -4
Return:
	eret				# return from exceptions
