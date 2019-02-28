#Laboratory Exercise 3, Home Assignment 6
.data
	i: 	.word 0
	n:	.word 6
	step:	.word 1
	list:	.word 3, -3, 6, -7, 2, 4
	max:	.word 0
	element:	.word 0

.text
	la	$t8, i
	lw	$s1, 0($t8)	# s1 -> i
	la	$t8, n
	lw	$s2, 0($t8)	# s2 -> n
	la	$s3, list	# s3 -> address(list)
	la	$t8, step
	lw	$s4, 0($t8)	# s4 -> step
	sub	$s1, $s1, $s4
	la	$t8, max
	lw	$s5, 0($t8)	# s5 -> max
	la	$t8, element
	lw	$s6, 0($t8)	# s6 -> max element
	
	loop:
		add 	$s1, $s1, $s4
		add	$t1, $s1, $s1
		add	$t1, $t1, $t1
		add	$t1, $t1, $s3
		lw	$t2, 0($t1)	# list[i]
		abs	$t3, $t2
		start:
			ble	$t3, $s5, else
			add	$s5, $zero, $t3
			add	$s6, $zero, $t2
			j	endif
		else:
		endif:
		blt	$s1, $s2, loop
		
li	$v0, 1
add	$a0, $zero, $s6
syscall
