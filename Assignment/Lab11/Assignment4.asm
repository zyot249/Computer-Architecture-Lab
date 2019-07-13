# Laboratory Exercise 11, Assignment 4

.eqv 	IN_ADDRESS_HEXA_KEYBOARD	0xFFFF0012
.eqv 	COUNTER 	0xFFFF0013			# Time counter

.eqv	MASK_CAUSE_COUNTER 0x00000400			# Bit 10: counter interrupt	
.eqv	MASK_CAUSE_KEYMATRIX  0x00000800		# Bit 11: Key matrix interrupt

.data
	Msg_keypress: 	.asciiz "You have just pressed a key!!\n"
	Msg_counter: 	.asciiz "Time interval!!\n"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAIN Procedure
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.text
Main:
	#---------------------------------------------------------
	# Enable interrupts you expect
	#---------------------------------------------------------
	# Enable the interrupt of Keyboard matrix 4x4 of Digital Lab Sim
	#---------------------------------------------------------
	li 	$t1, IN_ADDRESS_HEXA_KEYBOARD
	li 	$t3, 0x80			# bit 7 to enable
	sb 	$t3, 0($t1)
	
	 # Enable the interrupt of time counter of digital lab sim
	 li 	$t1, COUNTER
	 sb 	$t1, 0($t1)
	 
	#---------------------------------------------------------
	# Loop to print a sequence of numbers 
	#---------------------------------------------------------
Loop:
	nop
	nop
	nop
Sleep:
	li 	$v0, 32				# BUG: must sleep to wait 200ms
	li 	$a0, 200	
	syscall
	
	nop					# WARNING: nop is mandatory here
	b 	Loop
End_main:

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# GENERAL INTERRUPT SERVED ROUTINE for all interrupts
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.ktext 	0x80000180
IntSR:
	#---------------------------------------------------------
	# Temporary disable interrupt
	#---------------------------------------------------------
Dis_int:
	li 	$t1, COUNTER			# must be disabled with time counter
	sb 	$zero, 0($t1)
	# dont need to disable keyboard matrix interrupt
	#---------------------------------------------------------
	# Processing
	#---------------------------------------------------------
Get_caus:
	mfc0	$t1,$13				# $t1 = Coproc0.cause
IsCount:
	li 	$t2, MASK_CAUSE_COUNTER		# if cause counter confirm counter..
	and 	$at, $t1, $t2	
	beq 	$at, $t2, Counter_Intr
	nop
IsKeyMa:
	li 	$t2, MASK_CAUSE_KEYMATRIX 	# if cause value confirm key 
	and 	$at, $t1, $t2		
	beq 	$at, $t2, Keymatrix_Intr
	nop
Others:
	j 	End_process

#==================================================
Counter_Intr:
	li 	$v0, 4
	la 	$a0, Msg_counter
	syscall
	j 	End_process
#==================================================
Keymatrix_Intr:
	li 	$v0, 4
	la 	$a0, Msg_keypress
	syscall
	j 	End_process
#==================================================
	
End_process:
	mtc0 	$zero, $13		# must clear cause reg
	
En_int: #--------------------------------------------------------
	# Re-enable interrupt
	#--------------------------------------------------------
	li 	$t1, COUNTER
	sb 	$t1, 0($t1)
	#--------------------------------------------------------
	# Evaluate the return address of main routine
	# epc <= epc + 4
	#--------------------------------------------------------
Next_pc:
	mfc0 	$at, $14 		# $at <= Coproc0.$14 = Coproc0.epc
	addi 	$at, $at, 4 		# $at = $at + 4 (next instruction)
	mtc0 	$at, $14 		# Coproc0.$14 = Coproc0.epc <= $at
Return: 
	eret 				# return from exception
