# Laboratory Exercise 11, Assignment 1

# col		0x1	0x2	0x4	0x8
# row 0x1	0	1	2	3
#		0x11	0x21	0x41	0x81
# row 0x2	4	5	6	7
#		0x12	0x22	0x42	0x82
# row 0x4	8	9	A	B
# 		0x14	0x24	0x44	0x84
# row 0x8	C	D	E	F
#		0x18	0x28	0x48	0x88

#===============================================================
# command row number of hexadecimal key board (bit 0 to 3)
.eqv 	IN_ADDRESS_HEXA_KEYBOARD	0xFFFF0012
# eg: 0x11 : button 0 pressed
.eqv	OUT_ADDRESS_HEXA_KEYBOARD	0xFFFF0014
# eg: 0x28 : button D pressed

.text
Main:
	li	$t1, IN_ADDRESS_HEXA_KEYBOARD
	li 	$t2, OUT_ADDRESS_HEXA_KEYBOARD
	li 	$t3, 0x01 # check row key C, D, E, F
	
Polling:
	sb 	$t3, 0($t1)
	lb 	$a0, 0($t2)
Print:
	li 	$v0, 34
	syscall
	li 	$v0, 11
	la 	$a0, '\n'
	syscall
	
Sleep:
	li 	$v0, 32
	li 	$a0, 100
	syscall
Shift:
	sll 	$t3, $t3, 1
	li 	$t4, 0x10
	beq 	$t3, $t4, Reset
	nop
	j 	Back_to_polling
Reset:
	li 	$t3, 0x01
Back_to_polling:
	j 	Polling
