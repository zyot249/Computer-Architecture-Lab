#Laboratory Exercise 7, Assignment 2
.data
Message: .asciiz "The largest number is "
.text
main:
	li 	$a0, 24	
	li 	$a1, -9	
	li 	$a2, 31
	jal 	find_max
end_main:
	li 	$v0, 56
	la 	$a0, Message
	la 	$a1, 0($s0)
	syscall
	li 	$v0, 10			#exit
	syscall

#============================ find_max procedure ==========================
# $s0 = max_vlaue

find_max:
	addi 	$s0,$a0,0		# init max = a0
	blt 	$a1,$a0,continue_check
	addi 	$s0,$a1,0		# max --> a1
continue_check:
	blt 	$a2,$a1,end_check
	addi 	$s0,$a2,0		# max --> a2
end_check:
	jr  	$ra
	
	
