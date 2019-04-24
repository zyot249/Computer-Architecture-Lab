#Laboratory exercise 7, assignment 1
.data
Mess: .asciiz "The absolute value : "
.text
main:
	li $a0,-45	#input parameter
	jal absolute		#jump and link to abs procedure
	
	li $v0,56	#terminate
	la $a0,Mess
	syscall
	li $v0,10
	syscall
endmain:	
#==========================================================================
# $a1 : the integer needs to be gained the absolute value
# return $v0 : absolute value
#==========================================================================
absolute:
	bltz $a0,make_abs
	la $a1,0($a0)
	j done
make_abs:
	sub $a1,$zero,$a0	# put -(a1) into $v0
done:	
	jr $ra

	
	 
	
	
	
	
	
	
