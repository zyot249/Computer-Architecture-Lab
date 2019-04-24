#Laboratory Exercise 7, Assignment 1
.data
Message: .asciiz "The absolute value : "
.text
main:
	li 	$a0, 26			# input parameter
	jal 	absolute		# jump and link to abs procedure
	
	li 	$v0, 56			# terminate
	la 	$a0, Message
	syscall
	li 	$v0, 10
	syscall
end_main:	
#==========================================================================
# params $a1 : the integer needs to be gained the absolute value
# return $v0 : absolute value
#==========================================================================
absolute:
	bltz 	$a0, take_abs		# if input < 0 --> take_abs
	la 	$a1, 0($a0)
	j 	done 
take_abs:
	sub 	$a1, $zero, $a0		# put -(a1) into $v0
done:	
	jr 	$ra
