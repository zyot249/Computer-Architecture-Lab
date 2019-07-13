.eqv	MONITOR_SCREEN	0x10010000
.eqv	RED		0x00ff0000
.eqv	GREEN		0x0000ff00
.eqv	BLUE		0x00c8ddf2
.eqv	WHITE		0x00ffffff
.eqv	YELLOW		0x00ffff11
.text
	li	$k0, MONITOR_SCREEN
	
	li	$t0, RED
	sw	$t0, 0($k0)
	nop
	
	li	$t0, BLUE
	sw	$t0, 4($k0)
	nop
	
	li	$t0, WHITE
	sw	$t0, 8($k0)
	nop
	
	li	$t0, BLUE
	sw	$t0, 12($k0)
	nop
	
	li	$t0, YELLOW
	sw	$t0, 60($k0)
	nop