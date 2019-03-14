#Laboratory Exercise 4, Assignment 3

.text
	addi $s0, $zero, -4
	# abs
	sra $at, $s0, 0x0000001f
	xor $s1, $s0, $at
	subu $s1, $s1, $at
	# move
	add $s2, $zero, $s0
	andi $s0, $s0, 0x0
	# not
	nor $s1, $s2, $zero
	# ble s1, s2, label
	slt $t1, $s2, $s1
	beq $t1, $zero, label
	j exit
label:
exit:
	
