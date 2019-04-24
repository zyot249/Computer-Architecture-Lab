#Laboratory exercise 7, assignment 4
.data
Mess: .asciiz "The factorial value is "
.text
main:
	jal WRAP
print:
	li $v0,56
	la $a0,Mess
	syscall
quit:
	li $v0,10
	syscall
end_main:
#=================================================================
#Procedure WRAP : assign value and call FACT 
#=================================================================

WRAP:
	sw $fp,-4($sp)		#save frame pointer (1)
	addi $fp,$sp,0		#new frame pointer to the top
	addi $fp,$sp,-8		#adjust stack pointer
	sw $ra,0($sp)		#save return address
		
	li $a0,3		#load test input N
	jal FACT		#call fact procedure
	nop
	
	lw $ra,0($sp)		#restore return address
	addi $sp,$fp,0		#return stack pointer
	lw $fp,-4($sp)		#return frame pointer
	jr $ra
WRAP_END:

#================================================================
#Procedure FACT : compute N!
#param $a0 : integer N
#param $a1 : N! 
   
#int FACT(int n){
#	if (n < 2) return 1;
#	else return n*FACT(n-1); 
#}

#================================================================

FACT:
	sw $fp,-4($sp)		#save frame pointer
	addi $fp,$sp,0		#new frame pointer point to stack's top
	
	addi $sp,$sp,-12	#allocate space for $fp,$ra,$a0 in stack
	sw $ra,4($sp)		#save return address
	sw $a0,0($sp)		#save $a0 register
	
	slti $t0,$a0,2		#if input argument N<2
	beq $t0,$zero,recursive #if ((a0 = N ) >= 2)
	nop
	li $a1,1		#return the result N!=1
	j done
recursive:
	addi $a0,$a0,-1		#do FACT(n-1)		
	jal FACT
	nop
	lw $v1,0($sp)		#load a0
	mult $v1,$a1		#compute result
	mflo $a1
done:
	lw $ra,4($sp)		#restore return address
	lw $a0,0($sp)		#restore a0
	addi $sp,$fp,0		#restore stack pointer
	lw $fp,-4($sp)		#restore frame pointer
	jr $ra			#jump to calling
fact_end:
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
