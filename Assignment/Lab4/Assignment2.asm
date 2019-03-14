#Laboratory Exercise 4, Assignment 2

.text
	addi $s0, $zero, 0x12345678
	
	#Extract MSB of s0
	andi $t0, $s0, 0xff000000
	
	#Clear LSB of s0
	andi $t1, $s0, 0xffffff00	#extract LSB of s0
	
	#Set LSB of s0
	ori $s0, $s0, 0xff
	
	#Clear s0
	xor $s0, $s0, $s0
