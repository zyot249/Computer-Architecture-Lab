#Laboratory exercise 7, assignment 2
.data
Mess: .asciiz "The largest number is "
.text
#=================================== main =================================
main:
	li $a0,12	
	li $a1,-8	
	li $a2,1998
	jal find_max
end_main:
	li $v0,56
	la $a0,Mess
	la $a1,0($s0)
	syscall
	li $v0,10	#exit
	syscall

#============================ find_max procedure ==========================
# $s0 = max_vlaue
find_max:
	addi $s0,$a0,0		#init max = a0
	blt $a1,$a0,continue_check
reset_max1:
	addi $s0,$a1,0
continue_check:
	blt $a2,$a1,end_check
reset_max2:
	addi $s0,$a2,0
end_check:
	jr  $ra
	
	
	
	
