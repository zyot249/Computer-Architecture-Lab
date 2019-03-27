# Laboratory Exercise 6, Assignment 4

.data
	Arr: 	.word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 26, 7
	n: 	.word 13					# n = number of elements in Array A

.text
	main: 	
		la 	$s0,Arr 			# s0 = Address(A[0])
		la 	$t1,n
 		lw 	$s1,0($t1) 		# s1 = n
 		li 	$t8, 0			# t8 = i = 0
 		j 	insertion_sort 		# sort
	after_sort: 	
		li 	$v0, 10 		# exit
 		syscall
	end_main:

	insertion_sort: 		
	i_loop:	
		addi	$t8, $t8, 1		# i = i+1
		beq	$t8,$s1,done 		# i = n -> single element list is sorted
		add 	$t0, $t8, $t8		# t0 = 2i
		add	$t0, $t0, $t0		# t0 = 4i
		add	$t6, $s0, $t0		# t6 = address of the Key
		lw 	$t7, 0($t6)		# t7 = Key
		subi	$t9, $t8, 1		# j = i-1 
 		j 	while		

	done: 	
		j 	after_sort
	
	while:	
		add 	$t1, $t9, $t9		# t0 = 2j
		add 	$t1, $t1, $t1		# t0 = 4j
		add 	$t2, $s0, $t1 		# t2 = address of A[j]
		lw 	$t3, 0($t2)		# t3 = A[j]
		slt	$s6, $t7, $t3		# (key < A[j]) ?
		sge	$s5, $t9, $zero 	# (j >= 0) ?
		and	$s7, $s5, $s6		# s7 = (j >= 0 && A[j] > key)
		beq	$s7, $zero, end_of_while 
		add	$t4, $t2, 4		# t4 = address of A[j+1]
		sw 	$t3, 0($t4)		# A[j+1] = A[j]
		subi	$t9, $t9, 1		# j = j - 1 
		j 	while	
	end_of_while:	
		add	$t4, $t2, 4		# t4 = address of A[j+1]
		sw 	$t7, 0($t4)		# A[j+1] = Key
		j 	i_loop	
		
