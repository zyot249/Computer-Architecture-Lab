#Laboratory 3, Home Assigment 2
# s1 -> i, s3 -> n, s4 -> step
.data 
	A:	.word 3, 0, 1, 2, 6, -2, 4, 7, 3, 7 # array A
	i:	.word 0
	n:	.word 6
	step:	.word 1
	sum:	.word 0
.text
	la	$t4, i
	lw	$s1, 0($t4)	#s1 = i
	la	$t5, n
	lw	$s3, 0($t5)	#s3 = n
	subi	$s3, $s3, 1	#n = n - 1
	la	$t6, step
	lw	$s4, 0($t6)	#s4 = step
	la	$s2, A		#s2 = address(A)
	la	$t7, sum
	lw	$5, 0($t7)	#s5 = sum
	sub	$s1, $s1, $s4	#i = i - step
	
loop: 	add	$s1,$s1,$s4 	#i=i+step
	add	$t1,$s1,$s1 	#t1=2*s1
	add	$t1,$t1,$t1 	#t1=4*s1
	add	$t1,$t1,$s2 	#t1 store the address of A[i]
	lw	$t0,0($t1) 	#load value of A[i] in $t0
	add	$s5,$s5,$t0 	#sum=sum+A[i]
	bne	$s1,$s3,loop 	#if i != n, goto loop














