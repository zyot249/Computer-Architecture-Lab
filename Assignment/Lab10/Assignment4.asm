# Laboratory Exercise 10, Assignment 4
.eqv KEY_CODE 0xFFFF0004 	# ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 	# =1 if has a new keycode ?
 				# Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C 	# ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 	# =1 if the display has already to do
 				# Auto clear after sw
.text
 	li $k0, KEY_CODE
 	li $k1, KEY_READY

 	li $s0, DISPLAY_CODE
 	li $s1, DISPLAY_READY
loop: 	nop

WaitForKey: 	lw $t1, 0($k1) 			# $t1 = [$k1] = KEY_READY
 		nop
 		beq $t1, $zero, WaitForKey	# if $t1 == 0 then Polling
 		nop
 		#-----------------------------------------------------
ReadKey: 	lw $t0, 0($k0) 			# $t0 = [$k0] = KEY_CODE
 		nop
 		#-----------------------------------------------------
check_exit:
switch:
	beq $t0, 'e', case_e
	nop
	beq $t0, 'x', case_x
	nop
	beq $t0, 'i', case_i
	nop
	beq $t0, 't', case_t
	nop
	li $t3, 0
	j WaitForDis
case_e:
	bne $t3, 0, recover
	nop
	addi $t3, $t3, 1	# we have 'e' -> count = 1
	j WaitForDis
case_x:
	bne $t3, 1, recover
	nop
	addi $t3, $t3, 1	# we have 'ex' -> count = 2
	j WaitForDis
case_i:
	bne $t3, 2, recover
	nop
	addi $t3, $t3, 1	# we have 'exi' -> count = 3
	j WaitForDis
case_t:
	bne $t3, 3, recover
	nop
	j Exit			# now we have "exit" -> exit the program

recover:
	li $t3, 0
 		#-----------------------------------------------------
WaitForDis: 	lw $t2, 0($s1) 			# $t2 = [$s1] = DISPLAY_READY
 		nop
		beq $t2, $zero, WaitForDis 	# if $t2 == 0 then Polling
 		nop
 		#-----------------------------------------------------
Encrypt: 	addi $t0, $t0, 1 		# change input key
 		#-----------------------------------------------------
ShowKey: 	sw $t0, 0($s0) 			# show key
 		nop
		 #-----------------------------------------------------
 		j loop
 		nop
Exit:		la $v0, 10 
		syscall