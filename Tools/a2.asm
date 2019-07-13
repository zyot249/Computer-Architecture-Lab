.eqv	IN_ADRESS_HEXA_KEYBOARD	0xFFFF0012

.data
	Message: .asciiz "Oh my god. Someone's presed a button.\n"

.text
	main:
		li	$t1, IN_ADRESS_HEXA_KEYBOARD
		li	$t3, 0x80
		sb	$t3, 0($t1)
	Loop:
		nop
		nop
		nop
		nop
		b	Loop
	end_main:
	
.ktext 0x80000180
	IntSR:
		addi	$v0, $zero, 4
		la	$a0, Message
		syscall
	next_pc:
		mfc0	$at, $14
		addi	$at, $at, 4
		mtc0	$at, $14
	return:
		eret
		