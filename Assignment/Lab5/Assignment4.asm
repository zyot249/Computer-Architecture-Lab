#Laboratory Exercise 5, Assignment 4
.data
	string:	.space	50
	Message1:	.asciiz "Nhap sau: "
	Message2:	.asciiz	"Do dai la: "
.text
	add	$a3, $zero, 0x0a
	main:
		get_string:
			li	$v0, 54
			la	$a0, Message1
			la	$a1, string
			la	$a2, 50
			syscall
		get_length: 
			la	$a0, string
			xor	$v0, $zero, $zero
			xor	$t0, $zero, $zero
		check_char:
			add	$t1, $a0, $t0
			lb	$t2, 0($t1)
			beq	$t2, $a3, end_of_str
			beq	$t2, $zero, end_of_str
			add 	$v0, $v0, 1
			add	$t0, $t0, 1
			j	check_char
		end_of_str:
		end_of_get_length:
		print_length:
			add	$a1, $v0, $zero
			xor	$v0, $v0, $zero
			li	$v0, 56
			la	$a0, Message2
			syscall
			