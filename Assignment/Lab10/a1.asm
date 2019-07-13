.eqv	SEVENSEG_LEFT	0xFFFF0011
.eqv	SEVENSEG_RIGHT	0xFFFF0010

.text
main:
	li	$a0, 0x3f
	jal	SHOW_7SEG_LEFT
	nop
	li	$a0, 0x7F
	jal	SHOW_7SEG_RIGHT
	nop
exit:	
	li	$v0, 10
	syscall
endmain:

SHOW_7SEG_LEFT:
	li	$t0, SEVENSEG_LEFT
	sb	$a0, 0($t0)
	nop
	jr	$ra
	nop
	
SHOW_7SEG_RIGHT:
	li	$t0, SEVENSEG_RIGHT
	sb	$a0, 0($t0)
	nop
	jr	$ra
	nop