# Laboratory Exercise 10, Assignment 2
.eqv	MONITOR_SCREEN	0x10010000
.eqv	RED		0x00ff0000
.eqv	GREEN		0x0000ff00
.eqv	BLUE		0x00c8ddf2
.eqv	WHITE		0x00ffffff
.eqv	YELLOW		0x00ffff11
.text
	li	$k0, MONITOR_SCREEN
	
	li	$t0, RED
	sw	$t0, 12($k0)
	nop
	
	li	$t0, RED
	sw	$t0, 40($k0)
	nop
	
	li	$t0, RED
	sw	$t0, 68($k0)
	nop
	
	li	$t0, RED
	sw	$t0, 96($k0)
	nop
	
	li	$t0, YELLOW
	sw	$t0, 100($k0)
	nop

	li	$t0, YELLOW
	sw	$t0, 104($k0)
	nop
	
	li	$t0, YELLOW
	sw	$t0, 108($k0)
	nop
	
	li	$t0, YELLOW
	sw	$t0, 112($k0)
	nop
	
	li	$t0, YELLOW
	sw	$t0, 116($k0)
	nop
	
	li	$t0, YELLOW
	sw	$t0, 120($k0)
	nop
	
	li	$t0, YELLOW
	sw	$t0, 124($k0)
	nop
	
	li	$t0, RED
	sw	$t0, 152($k0)
	nop
	
	li	$t0, RED
	sw	$t0, 180($k0)
	nop
	
	li	$t0, RED
	sw	$t0, 208($k0)
	nop
	
	li	$t0, RED
	sw	$t0, 236($k0)
	nop
