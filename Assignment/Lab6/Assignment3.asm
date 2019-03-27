# Laboratory Exercise 6, Assignment 3

.data
	Arr: 	.word 	7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 26, 7
	n: 	.word 	13			# n = number of elements in Array A

.text
	main: 	
		la 	$s0, Arr		# s0 = Address(A[0])
		la 	$t1, n
 		lw 	$s1, 0($t1) 		# s1 = n
 		subi	$s1, $s1, 1		# s1 = n-1
 		li 	$t8, -1			# t8 = i = -1
 		j 	bubble_sort 		# sort
	after_sort: 	
		li 	$v0, 10 		# exit
 		syscall
	end_main:

	bubble_sort: 		
	i_loop:		
		addi 	$t8, $t8, 1		# i = i+1
		beq 	$t8,$s1,done 		# i = n-1 -> single element list is sorted
 		j	j_loop 		

	done: 		
		j after_sort

	j_loop:		
		li 	$t9, -1			# t9 = j = -1
		sub 	$t7, $s1, $t8		# t7 = n-i-1
	continue:	
		addi 	$t9, $t9, 1		# j = j+1
		beq 	$t9, $t7, i_loop	# if j = n-i-1 -> break -> go to i loop
		add 	$t0,$t9,$t9 		# t0 = 2j
 		add 	$t0,$t0,$t0		# t0 = 4j
 		add 	$t1,$s0,$t0		# t1 = address of A[j]
 		lw 	$t2, 0($t1)		# t2 = A[j]
 		addi 	$t3, $t1,4		# t3 = address of A[j+1]
 		lw 	$t4, 0($t3)		# t4 = A[j+1]
 			
 		
 		ble 	$t2,$t4, continue	# if A[j] <= A[j+1] -> continue, otherwise -> swap 
		sw 	$t2, 0($t3)		# A[j+1] = A[j]
		sw 	$t4, 0($t1) 		# A[j] = A[j+1]
		j 	continue 		
		
		
				
