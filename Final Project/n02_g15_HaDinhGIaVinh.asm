#--------------------------Initial settings--------------------------#
.eqv INPUT_CHARACTER 0xFFFF0004  		# ASCII code to show, 1 byte 
.eqv CHARACTER_CONDITION 0xFFFF0000        		# =1 if has a new keycode ?                                  
						# Auto clear after lw 
.eqv SHOW_CHARACTER 0xFFFF000C 			# ASCII code to show, 1 byte 
.eqv SHOW_CONDITION 0xFFFF0008			# =1 if the display has already to do                                  
						# Auto clear after sw 
.data
L :	.asciiz "a"
R : 	.asciiz "d"				#Store string in the memory and null terminate it	
U: 	.asciiz "w"
D: 	.asciiz "s"
#points:
#	.word 	200, 10
#	.word 	170, 40
#	.word	240, 60
#	.word 	240, 30
.text	
	li $k0, INPUT_CHARACTER 		# store the input character
	li $k1, CHARACTER_CONDITION		# check if there is any character  
	li $s2, SHOW_CHARACTER			# display the input character
	li $s1, SHOW_CONDITION			# check if the screen is ready to display
	
	addi	$s7, $0, 512			# set the default width and height and store it in $s7
	
	#circle setting:
	addi	$a0, $0, 256			# cx = 256
	addi	$a1, $0, 256			# cy = 256, (cx,cy) is the coordinate of the circle	
	addi	$a2, $0, 20			#r = 20 r is the radius of the circl
	addi 	$s0, $0, 0x00F366FF		# the color of circle
	jal 	makeCircle	
	nop

Input:
	ReadKey: lw $t0, 0($k0) 		# $t0 = [$k0] = KEY_CODE
	j moving

moving:						# moving functions
	
	beq $t0,97,goLeft
	beq $t0,100,goRight	 		# decide the direction by detecting the input from the keyboard by using ASCII code
	beq $t0,115,goDown
	beq $t0,119,goUp	
	beq $t0,20,stop
	j Input
	stop:					#stop
		addi $s0,$0,0x00000000		#delete the circl by making its color to black then draw upon the old circle
		jal makeCircle
		j Input
	goLeft:					#going left
		addi $s0,$0,0x00000000		#delete the circl by making its color to black then draw upon the old circle
		jal makeCircle
		addi $a0,$a0,-1			#decrease cx
		add $a1,$a1, $0			#going left so cy remains the old value
		addi $s0,$0,0x00F366FF
		jal makeCircle
		#jal Modify
		bltu $a0,20,bounceRight	#if the circle reach the left boundary, bounce back
		j Input
	goRight: 				#going right
		addi $s0,$0,0x00000000		#delete the circl by making its color to black then draw upon the old circle
		jal makeCircle
		addi $a0,$a0,1			#increase cx
		add $a1,$a1, $0			#going right so cy remains the old value
		addi $s0,$0,0x00F366FF
		jal makeCircle
		#jal Modify
		bgtu $a0,492,bounceLeft	#if the circle reach the right boundary, bounce back
		j Input
	goUp:					#going up
		addi $s0,$0,0x00000000		#delete the circl by making its color to black then draw upon the old circle
		jal makeCircle
		addi $a1,$a1,-1			#decrease cy
		add $a0,$a0,$0			#going up so cx remains the old value
		addi $s0,$0,0x00F366FF
		jal makeCircle
		#jal Modify
		bltu $a1,20,bounceDown		#if the circle reach the top boundary, bounce back
		j Input
	goDown: 				#going down
		addi $s0,$0,0x00000000		#delete the circl by making its color to black then draw upon the old circle
		jal makeCircle
		addi $a1,$a1,1			#increase cy
		add $a0,$a0,$0			#going down so cx remains the old value
		addi $s0,$0,0x00F366FF
		jal makeCircle
		#jal Modify
		bgtu $a1,492,bounceUp		#if the circle reach the bottom boundary, bounce back
		j Input
	bounceLeft:				#set the new value for input which is opposite with the current direction
		li $t3 97
		sw $t3,0($k0)
		j Input
	bounceRight:				#set the new value for input which is opposite with the current direction
		li $t3 100
		sw $t3,0($k0)
		j Input
	bounceDown:				#set the new value for input which is opposite with the current direction
		li $t3 115
		sw $t3,0($k0)
		j Input
	bounceUp:				#set the new value for input which is opposite with the current direction
		li $t3 119
		sw $t3,0($k0)
		j Input
endMoving:	
	
Modify:						#set the speed of the circle
	addiu $sp,$sp,-4			#move to the next position in the stack
	sw $a0, ($sp)				#store the current content of $a0 to the new position n the stack
	la $a0,	12				#set the length of time to sleep in miliseconds
	li $v0, 32	 			#syscall value for sleep
	syscall
	lw $a0,($sp)				#set the content of $a0 to the content of the current position in the stac
	addiu $sp,$sp,4				#move back to the former position in the stack
	jr $ra
	
makeCircle:
	# a0 = cx	a1 = cy		a2 = radius		s0 = color
	
	addiu	$sp, $sp, -32
	sw 	$ra, 28($sp)
	sw	$a0, 24($sp)
	sw	$a1, 20($sp)
	sw	$a2, 16($sp)			# store the original values of x,y,radius and color to preserve and those will be loaded back again later
	sw	$s4, 12($sp)
	sw	$s3, 8($sp)
	sw	$s2, 4($sp)
	sw	$s0, ($sp)
	
	# starting of the function
	sub	$s2, $0, $a2			# check =  -radius
	add	$s3, $0, $a2			# x = radius
	add	$s4, $0, $0			# y = 0 (s4)
	
	makeCircleLoop:
	bgt 	$s4, $s3, exitMakeCircle	# if y is greater than x, break the loop (while loop x >= y)
	nop
	
	# plots 4 points along the right of the circle, then swaps the x and y and plots the opposite 4 points
	jal	add8Octants
	nop
	
	add	$s2, $s2, $s4			# check += y
	addi	$s4, $s4, 1			# ++y
	add	$s2, $s2, $s4			# check += y
	
	blt	$s2, 0, makeCircleLoop		#if check >= 0, start loop again
	nop
	
	sub	$s3, $s3, 1			#--x
	sub	$s2, $s2, $s3			#check -= x
	sub	$s2, $s2, $s3			#check -= x
	
	j	makeCircleLoop
	nop	
	
	exitMakeCircle:
	
	lw	$s0, ($sp)
	lw	$s2, 4($sp)
	lw	$s3, 8($sp)
	lw	$s4, 12($sp)
	lw	$a2, 16($sp)			# retrieve original values and return address
	lw	$a1, 20($sp)
	lw	$a0, 24($sp)
	lw	$ra, 28($sp)
	
	addiu	$sp, $sp, 32
	
	jr 	$ra
	nop
	
add8Octants:
	addiu	$sp, $sp, -4
	sw	$ra, ($sp)
	
	jal	add4Octants
	nop
	
	beq 	$s4, $s3, skipSwap		# if x = y then we do not need to swap the values to generate points
	nop
	
	#swap y and x, and do it again
	add	$t2, $0, $s4			#puts y into t2
	add	$s4, $0, $s3			#puts x in to y
	add	$s3, $0, $t2			#puts y in to x
	
	jal	add4Octants
	nop
	
	#swap them back
	add	$t2, $0, $s4			#puts y into t2
	add	$s4, $0, $s3			#puts x in to y
	add	$s3, $0, $t2			#puts y in to x
		
	skipSwap:
		
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	
	jr	$ra
	nop
	
add4Octants:
	# add 4 points along the right side of the circle, then swaps the cx and cy values to do the opposite side
	addiu	$sp, $sp, -4
	sw	$ra, ($sp)
	
	#$a0 = a0 + s3, $a2 = a1 + s4
	add	$t0, $0, $a0			#store value of $a0 to $t0 (cx in t0)
	add	$t1, $0, $a1			#store value of $a1 to $t1 (cy in t1)
	
	add	$a0, $t0, $s3			#set a0 (x for the setpixel, to cx + x)
	add	$a2, $t1, $s4			#set a2 (y for setPixel to cy + y)
	
	jal	SetPixel			#draw the first pixel
	nop
	
	sub	$a0, $t0, $s3			#cx - x
	
	beq	$s3, $0, skipXifEqual0 		#if s3 (x) equals 0, skip
	nop
	
	jal 	SetPixel			#if x!=0 (cx - x, cy + y)
	nop	

	skipXifEqual0:	
	sub	$a2, $t1, $s4			#cy - y (a0 already equals cx - x
	jal 	SetPixel			#no if	 (cx - x, cy - y)
	nop
	
	add	$a0, $t0, $s3
	
	beq	$s4, $0, skipYifEqual0 		#if s4 (y) equals 0, skip
	nop
	
	jal	SetPixel			#if y!=0 (cx + x, cy - y)
	nop
	
	skipYifEqual0:
	
	add	$a0, $0, $t0			
	add	$a2, $0, $t1			
	
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	
	jr	$ra
	nop
SetPixel:
	#a0 x
	#a1 y
	#s0 colour
	addiu	$sp, $sp, -20			# Save return address on stack
	sw	$ra, 16($sp)
	sw	$s1, 12($sp)
	sw	$s0, 8($sp)			# Save original values of a0, s0, a2
	sw	$a0, 4($sp)
	sw	$a2, ($sp)

	lui	$s1, 0x1004			# starting address of the screen
	sll	$a0, $a0, 2 			# multiply 4 cause each time shift left the number multipled by 2
	add	$s1, $s1, $a0			# x co-ord of the circle addded to pixel position
	mul  	$a2, $a2, $s7			# multiply by width (s7 declared at top of program, never saved and loaded and it should never be changed)
	mul	$a2, $a2, 4			# myltiply by the size of the pixels (4), which is equal to the whole word
	add	$s1, $s1, $a2			# add y co-ord to pixel position

	sw	$s0, ($s1)			# stores the value of colour into the pixels memory address
	
	lw	$a2, ($sp)			# retrieve original values and return address
	lw	$a0, 4($sp)
	lw	$s0, 8($sp)
	lw	$s1, 12($sp)
	lw	$ra, 16($sp)
	addiu	$sp, $sp, 20	
	
	jr	$ra
	nop
	
