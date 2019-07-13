.data
	ask_msg:		.asciiz	"Enter the decimal number: "
	bin_result_msg:		.asciiz	"This number in binary is: "
	bin_result:		.space	65
.text
	li	$v0, 53
	la	$a0, ask_msg
	syscall
	bne	$a1, $zero, exit
	nop
	mfc1.d	$t8, $f0
	
	#print_bin
	# show msg
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
	
	j	exit
	
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
exit:
