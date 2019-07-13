#Mini project 4
.data
Mess: .asciiz "Input the number of elements: "
Mess1: .asciiz "Input value of the elements: "
Mess2: .asciiz "Max element of array: "
Mess3: .asciiz "Input m: "
Mess4: .asciiz "Input M: "
Mess5: .asciiz "The number of elements in range of (m,M) is "
error_msg1: .asciiz "The number must be greater than zero"
error_msg2: .asciiz "The number must be smaller "
error_msg3: .asciiz "Incorrect type"
.text
#Enter the information for the array

	li $v0,51 				#specify the syscall function
	la $a0,Mess 				# set a0 = address of Mess
	
	syscall
	blez $a0, printMess
	
	
printMess: #check the condition
	bge $a0,0,continue1
	li $v0,51
	la $a0,error_msg1
	syscall
	j printMess
end_printMess:


continue1:
	bge $a0,9999,printMess2
	
	
printMess2: #check the condition
	ble $a0,9999,continue2
	li $v0,51
	la $a0,error_msg2
	syscall
	j printMess2
end_printMess2:


continue2:
	beq $a1,-1,printMess3
	
	
printMess3:
	beq $a1,0,begin_input
	li $v0,51
	la $a0,error_msg3
	syscall
	j printMess3
end_printMess3:	


#========================================================================
# a2 : number of elements in the array
# s0 : counter
# a3 : max value in the array	
begin_input:
	la $a2,0($a0) #load the value of the first element in the array
	addi $s0,$zero,0 #set the counter = 0
# input loop for user to input value and store them into stack


input_loop:
	bge $s0,$a2,end_input_loop #if s0 >= a2, branch to end-input-loop
	
	li $v0,51 #specify the syscall function
	la $a0,Mess1 #set a0 = Mess1's address
	syscall 
	
	bge $a0,9999,printMess4
printMess4: #check the condition
	ble $a0,9999,continue4
	li $v0,51
	la $a0,error_msg2
	syscall
	j printMess4
end_printMess4:

continue4:	
	beq $a1,-1,printMess5
	
printMess5:
	beq $a1,0,continue5
	li $v0,51
	la $a0,error_msg3
	syscall
	j printMess5
end_printMess5:	

continue5:
	sw $a0,0($sp) #store the value of a0 into into stack
	addi $sp,$sp,-4 #point to the different location in stack
	addi $s0,$s0,1 #increase counter
	j input_loop
end_input_loop:

#================================================================
#find max value procedure
# @brief	return the element has the biggest value in the integer array
# @param[in]	a0 global variable, carrying the int array address
# 		s0 counter
#		sp carrying the value of elements in the array
# 		t1 variable to save the value of the current node in the stackpointer
# 		s1 initial value of max
# 		s3 variable to save the value of new max if detected
# @return	s1 	Register carrying the max value
#================================================================
	la $t1,0($s0)				#set t1 = the current value of s0
	lw $s1,4($sp)				# init temp max = the first element
	addi $sp,$sp,4				#point to the next element in stack
find_max_loop:
	blez $t1,end_find_max_loop		#if t1 <= 0 end loop
	lw $s2,4($sp) 				# set s2 = the first element in the stack
	blt $s2,$s1,continue 			#if s2 <= s1, branch to continue
	nop
	
modify_max:
	la $s1,0($s2) 				#if s2 >= s1, chang max = s2
end_modify_max:
continue:
	addi $t1,$t1,-1				# decrease the value of t1
	addi $sp,$sp,4				#move to the next element in stack
	j find_max_loop				#continue the loop to find max
end_find_max_loop:
	addi $a3,$s1,0 				#set a3 = s1 ( s1 = max)

	li $v0,56 				#specify the syscall function
	la $a0,Mess2 				# set a0 = address of Mess2
	addi $a1,$a3,0 				#set a1 = a3
	syscall

#==========================================================
#function to find the number of elements in range (m,M) procedure
# @param[in]	a0 global variable, carrying the int array address
# 		s2 counter
#		sp carrying the value of elements in the array
# 		s3 = m 
# 		s4 = M 
# @return	a3 = number of elements satisfy the condition
#==========================================================

	addi $s2,$zero,0			#counter adjust stack to top
adjust_stack:
	bge $s2,$a2,end_adjust_stack 		#these lines of code rearrange 
	addi $sp,$sp,-4				#the pointer of the stack
	addi $s2,$s2,1				#make it point to the first element in the stack
	j adjust_stack
end_adjust_stack:
	
# input m & M 
	li $v0,51 
	la $a0,Mess3
	syscall
	addi $s3,$a0,0 				#after syscall, set the value of s3 to m
	
	li $v0,51
	la $a0,Mess4
	syscall
	addi $s4,$a0,0 				#after syscall, set the value of s4 to M
	
# count the number of element
	addi $a3,$zero,0
count_loop:
	blez $s2,end_count_loop			#if all the elements are checked, stop loop
	lw $t0,0($sp)				#load the value of the first element in the stack
	bge $t0,$s3,condition			#check if it >= m, if it is, jump to condition 
	nop
	j continue_loop				#else jump to continue_loop
condition:
	ble $t0,$s4,count			#if it is smaller than M, jumpto count 
	nop
	j continue_loop
	
count:
	addi $a3,$a3,1				#increase count by 1
end_count:

end_condition:

continue_loop:
	addi $s2,$s2,-1				#decrease s2
	addi $sp,$sp,4				#point to the next element in the stack pointer
	j count_loop
end_count_loop:

	li $v0,56				#inform 
	la $a0,Mess5				#user  	
	addi $a1,$a3,0				#the result
	syscall
	

	
	
	

		
