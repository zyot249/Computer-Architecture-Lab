# Mini Project 5
# Problem: Write a program to get decimal numbers, display those numbers in binary and hexadecimal
.data
	ask_msg:		.asciiz	"Enter the decimal number: "
	bin_result_msg:		.asciiz	"This number in binary is: "
	hex_result_msg:		.asciiz	"This number in hexadecimal is: 0x"
	wrong_input_msg:	.asciiz	"The input must be a decimal number!"
	no_input_msg:		.asciiz	"Please enter a decimal number as input or choose cancel!"
	bin_result:		.space 	65
	hex_result:		.space	17
.text
.globl __start
	__start:
	# get the input
	li	$v0, 53
	la	$a0, ask_msg
	syscall
	bne	$a1, $zero, check_input
	nop
	# save input in t8 and t9
	mfc1.d	$t8, $f0
	
	#print_bin
	# show msg
	#li	$v0, 4
	#la	$a0, bin_result_msg
	#syscall
	add	$s1, $zero, $t9
	add	$s5, $zero, $zero	
	jal	print_bin
	nop
	add	$s1, $zero, $t8
	jal	print_bin
	nop
	li	$v0, 59
	la	$a0, bin_result_msg
	la	$a1, bin_result
	syscall
	# new line
	#li	$v0, 11
	#li	$a0, 10
	#syscall
	
	# print_hex
	# show msg
	#li	$v0, 4
	#la	$a0, hex_result_msg
	#syscall
	
	add	$s1, $zero, $t9
	add	$s5, $zero, $zero
	jal	print_hex
	nop
	add	$s1, $zero, $t8
	jal	print_hex
	nop	
	# new line
	#li	$v0, 11
	#li	$a0, 10
	#syscall
	li	$v0, 59
	la	$a0, hex_result_msg
	la	$a1, hex_result
	syscall
	j	__start
	#j	exit
#----------------------------------------------------------------------------------
# print binary proceduce
# @brief	print binary-form of input number
# @param[in] s1 : the value of input number
# t0 : temporary register for storing input number
# t1 : the result when searching each bit of input number
# t3 : mask to get each bit of number
# t4 : number of loops
#----------------------------------------------------------------------------------

print_bin:
	# print bin
	add	$t0, $zero, $s1		# save value of integer to t0
	add	$t1, $zero, $zero	# t1 = 0 (result of getting each binary bit from t0)
	addi	$t3, $zero, 1		# initial t3 = 1 (we will get each bit of t0 by using 1 bit 1 of t3)
	sll	$t3, $t3, 31		# shift left 31 --> bit 1 of t3 in the left most
	addi	$t4, $zero, 32		# number of loop (get 32 bits of t0)
	
	bin_loop:
		and	$t1, $t0, $t3		# AND t3, t0 --> get each bit of t0
		beq	$t1, $zero, print	# if t1 == 0 --> print
		
		add	$t1, $zero, $zero	# reset t1
		addi	$t1, $zero, 1		# set t1 = 1
		j	print			# print t1
		
	print:	
		la	$s6, bin_result
		add	$s6, $s6, $s5
		addi	$t1, $t1, 48
		sb	$t1, 0($s6)
		addi	$s5, $s5, 1
		
	srl	$t3, $t3, 1		# shift right to get next bit
	addi	$t4, $t4, -1		# decrease loop by 1
	bne	$t4, $zero, bin_loop	# if t4 != 0 --> continue loop
	
	jr	$ra
#----------------------------------------------------------------------------------
# print hexadecimal proceduce
# @brief	print hexadecimal-form of input number
# @param[in] s1 : the value of input number
# t0 : temporary register for storing input number
# t1 : the result when searching each bit of input number
# t3 : mask to get each bit of number
# t4 : number of loops
# t5 : number of bit that t0 will be shifted right to
# t6 : the result of comparison result t1 and 10
#----------------------------------------------------------------------------------
print_hex:

	# print hex
	add	$t0, $zero, $s1		# save value of integer to t0
	add	$t1, $zero, $zero	# t1 = 0 (result of getting each binary bit from t0)
	addi	$t3, $zero, 0xf		# initial t3 = f (we will get each 4-bit of t0 by using 4 bit 1 of t3)
	addi	$t4, $zero, 8		# number of loop (get 32 bits of t0)
	
	hex_loop:
		add	$t0, $zero, $s1			# save value of input to t0
		add	$t5, $t4, -1			# t5 = t4 -1 (number of shifting bit)
		add	$t5, $t5, $t5			# 
		add	$t5, $t5, $t5			# t5 <- 4*t5
		srlv	$t0, $t0, $t5			# shift right
		and 	$t1, $t0, $t3			# get 4-bit of input
		slti	$t6, $t1, 10			# compare result with 10
		beq	$t6, $zero, greater_ten		# if >= 10 --> a->f(letter) else (0->9) number
		nop
		
		la	$s6, hex_result
		add	$s6, $s6, $s5
		addi	$t1, $t1, 48
		sb	$t1, 0($s6)
		addi	$s5, $s5, 1
		#li	$v0, 11
		#add	$a0, $t1, 48			# 0->9 (48 -> 57)
		#syscall
		j	continue
		
		greater_ten:
			la	$s6, hex_result
			add	$s6, $s6, $s5
			addi	$t1, $t1, 55
			sb	$t1, 0($s6)
			addi	$s5, $s5, 1
			#li	$v0, 11
			#add	$a0, $t1, 55		# A->F (65 -> 71)
			#syscall
		continue:
			addi	$t4, $t4, -1		# decrease loop by 1
			bne	$t4, $zero, hex_loop	# if t4 != 0 --> continue loop 
		
	jr	$ra

check_input:
	beq	$a1, -1, wrong_input
	nop
	beq	$a1, -2, exit
	nop
	beq	$a1, -3, no_input
	nop
	
	wrong_input:
		li	$v0, 55
		la	$a0, wrong_input_msg
		li	$a1, 2
		syscall
		j	__start
	no_input:
		li	$v0, 55
		la	$a0, no_input_msg
		li	$a1, 2
		syscall
		j	__start
exit:
