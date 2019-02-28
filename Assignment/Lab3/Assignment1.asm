#Laboratory Exercise 3, Home Assignment 1
.data
	i: .word 2
	j: .word 3
	x: .word 6
	y: .word 6
	z: .word 6
.text
	la	$t8, i	#get address of i
	la	$t9, j	#get address of j
	lw	$s1,0($t8)	#s1 -> i
	lw	$s2,0($t9)	#s2 -> j
	
	la	$t8, x
	lw	$t1, 0($t8)
	la	$t8, y
	lw	$t2, 0($t8)
	la	$t8, z
	lw	$t3, 0($t8)
start: 
	slt $t0,$s2,$s1 	# j<i
	bne $t0,$zero,else 	# branch to else if j<i
	addi $t1,$t1,1 		# then part: x=x+1
	addi $t3,$zero,1 	# z=1
	j endif 		# skip “else” part
else: 	addi $t2,$t2,-1 	# begin else part: y=y-1
	add $t3,$t3,$t3 	# z=2*z
endif:





















