.eqv 	IN_ADRESS_HEXA_KEYBOARD		0xFFFF0012
.eqv 	OUT_ADRESS_HEXA_KEYBOARD	0xFFFF0014
.eqv	SEVENSEG_LEFT			0xFFFF0011
.eqv	SEVENSEG_RIGHT			0xFFFF0010

.text
main:
	li	$t1,IN_ADRESS_HEXA_KEYBOARD
	li	$t2,OUT_ADRESS_HEXA_KEYBOARD
	li	$t3,0x08	# check row 4 with key C, D, E, F
polling:
	sb	$t3,0($t1 )
	lb	$a0,0($t2)
print:
	li	$v0,34
	syscall
sleep:
	li	$a0,100
	li	$v0,32
	syscall
back_to_polling: 
	j	polling
	
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
# must reassign expected row
# read scan code of key button
# print integer (hexa)
# sleep 100ms
# continue polling