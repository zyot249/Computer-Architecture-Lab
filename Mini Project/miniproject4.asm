#Mini project 4
.data
Mess: .asciiz "Input the number of elements: "
Mess1: .asciiz "Input value of array: "
Mess2: .asciiz "Max value of array: "
Mess3: .asciiz "Input m: "
Mess4: .asciiz "Input M: "
Mess5: .asciiz "Number of elements in range of (m,M) is "
.text
	li $v0,51
	la $a0,Mess
	syscall
#================================================================	
# a2 : number of elements
# s0 : counter
# a3 : max value 
#================================================================		
	la $a2,0($a0)
	addi $s0,$zero,0
# input loop for user to input value and store them into stack
input_loop:
	bge $s0,$a2,end_input_loop
	
	li $v0,51
	la $a0,Mess1 
	syscall
	
	sw $a0,0($sp)
	addi $sp,$sp,-4
	addi $s0,$s0,1
	j input_loop
end_input_loop:

#================================================================
#function to find max
# a3 : max value
# s1 : temporary max
# s2 = s0
#================================================================
	la $t1,0($s0)
	lw $s1,4($sp) # init temp max = the first element
	addi $sp,$sp,4
find_max_loop:
	blez $t1,end_find_max_loop
	lw $s2,4($sp)
	blt $s2,$s1,continue
	nop
	
modify_max:
	la $s1,0($s2)
end_modify_max:
continue:
	addi $t1,$t1,-1
	addi $sp,$sp,4	
	j find_max_loop
end_find_max_loop:
	addi $a3,$s1,0

	li $v0,56
	la $a0,Mess2
	addi $a1,$a3,0
	syscall

#==========================================================
#function to find numberof elements in range (m,M)
# s3 = m
# s4 = M 
# a3 = number of elements
#==========================================================
	addi $s2,$zero,0	#counter adjust stack to top
adjust_stack:
	bge $s2,$a2,end_adjust_stack
	addi $sp,$sp,-4
	addi $s2,$s2,1
	j adjust_stack
end_adjust_stack:
	
# input m & M 
	li $v0,51
	la $a0,Mess3
	syscall
	addi $s3,$a0,0
	
	li $v0,51
	la $a0,Mess4
	syscall
	addi $s4,$a0,0
	
# calculate number of elements
	addi $a3,$zero,0
cal_loop:
	blez $s2,end_cal_loop
	lw $t0,0($sp)
	bge $t0,$s3,condition
	nop
	j continue_loop
condition:
	ble $t0,$s4,cnt_up
	nop
	j continue_loop
cnt_up:
	addi $a3,$a3,1
end_cal_up:

end_condition:

continue_loop:
	addi $s2,$s2,-1
	addi $sp,$sp,4
	j cal_loop
end_cal_loop:
	li $v0,56
	la $a0,Mess5
	addi $a1,$a3,0
	syscall
	

	
	
	

		
