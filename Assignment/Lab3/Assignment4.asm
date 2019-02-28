#Laboratory Exercise 3, Home Assignment 4
.data
	i: .word 2
	j: .word 3
	m: .word 1
	n: .word 5
	x: .word 6
	z: .word 6
	y: .word 6
.text
	la	$t8, i	#get address of i
	la	$t9, j	#get address of j
	lw	$s1,0($t8)	#s1 -> i
	lw	$s2,0($t9)	#s2 -> j
	
	la	$t7, m
	la	$t6, n
	lw	$s4,0($t7)	#s4 -> m
	lw	$s5,0($t6)	#s5 -> n
	
	la	$t8, x
	lw	$t1,0($t8)
	la	$t8, y
	lw	$t2,0($t8)
	la	$t8, z
	lw	$t3,0($t8)
start: 
	#i < j
	#slt $t0,$s1,$s2 	# i < j -> t0 = 1
	#beq $t0,$zero,else 	# branch to else if i >= j
	
	#i >= j
	#slt $t0,$s1,$s2 	# i < j -> t0 = 1
	#bne $t0,$zero,else	# branch to else if i < j
	
	#i + j <= 0
	#add $t0,$s1,$s2		# i + j -> t0
	#bgtz $t0,else		# branch to else if i + j > 0
	
	#i + j > m + n
	#add $t0, $s1, $s2	# i + j -> t0
	#sub $t0, $t0, $s4	#i +j - m -> t0
	#sub $t0, $t0, $s5	#i + j - m - n -> t0
	#blez $t0, else		# branch to else if t0 <= 0
	
	addi $t1,$t1,1 		# then part: x=x+1
	addi $t3,$zero,1 	# z=1
	j endif 		# skip “else” part
else: 	addi $t2,$t2,-1 	# begin else part: y=y-1
	add $t3,$t3,$t3 	# z=2*z
endif:





















