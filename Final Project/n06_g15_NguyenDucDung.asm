# Final Project, Problem 6
.data
	CharPtr:	.word	0
	CharPtr2:	.word	0
	BytePtr:	.word	0
	WordPtr:	.word	0
	Word2Ptr:	.word	0
	
	row:		.word	0		# luu lai so hang cua array
	col:		.word	0		# luu lai so cot cua array
	
	stringBuff:	.space	110
	charPtrLen:	.word	0		# luu lai do dai CharPtr
	
	TheTopOfMemSpace:	.word	0	# luu lai dia chi dau tien cua vung cap phat
	WastedMemory:		.word	0	# luu lai luong bo nho thua
	
	Message1:		.asciiz	"\nThe address of CharPtr, BytePtr, WordPtr are: "
	Message2:		.asciiz	"\nCharPtr: "
	Message3:		.asciiz	"\nCharPtr2: "
	Message4:		.asciiz	"Total allocated memory is: "
	Message5:		.asciiz	"Array[i][j]: "
	Message6:		.asciiz	"Enter the size of memory:"
	Message7:		.asciiz	"Enter the number of rows:"
	Message8:		.asciiz	"Enter the number of columns:"
	Message9:		.asciiz	"Enter the value:"
	Message10:		.asciiz	"The value is: " 
	Message11:		.asciiz "\nThe value of CharPtr, BytePtr, WordPtr are: "
	Message12:		.asciiz	"Enter the content of CharPtr:"
	ErrorMessage1:		.asciiz	"Segmentation Fault\n"
	ErrorNoInput:		.asciiz	"No input!"
	ErrorWrongInput:	.asciiz	"Wrong Input!"
	ErrorWrongInput1:	.asciiz	"PLEASE choose the option from 1->11"
	ErrorNegativeInput:	.asciiz	"Input must be greater than 0"
	ErrorTooLarge:		.asciiz	"Input should be less than or equal 1000"
	ErrorOverSize:		.asciiz	"Over Size!"
	
	Menu:	.asciiz "--------------------------MENU---------------------------\n1. Malloc char pointer\n2. Malloc byte pointer\n3. Malloc word pointer\n4. Get pointers' value\n5. Get pointers' address\n6. Copy 2 pointer strings\n7. Total memory allocated\n8. Malloc 2-D word\n9. SetArray[i][j]\n10.GetArray[i][j]\n11. Exit\n Please choose one option: "
.kdata
	# Bien chua dia chi dau tien cua vung nho con trong
	Sys_TheTopOfFree:	.word	1
	# Vung khong gian tu do, dung de cap bo nho cho cac bien con tro
	Sys_MyFreeSpace:

.text
main:
	# Khoi tao vung nho cap phat dong
	jal	SysInitMem
	nop
	# print menu
	PrintMenu:
		la	$a0, Menu
		jal	ShowDialog
		nop
		move	$s0, $a0		# Switch
		beq	$s0, 1, option1		# Malloc char pointer (1 and 2)
		nop
		beq	$s0, 2, option2		# Malloc byte pointer
		nop
		beq	$s0, 3, option3		# Malloc word pointer
		nop
		beq	$s0, 4, option4		# Get ptr value
		nop
		beq	$s0, 5, option5		# Get ptr address
		nop
		beq	$s0, 6, option6		# Copy 2 strings
		nop
		beq	$s0, 7, option7		# Total Allocated Memory
		nop
		beq	$s0, 8, option8		# Malloc 2-D ptr
		nop
		beq	$s0, 9, option9		# set Array[i][j]
		nop
		beq	$s0, 10, option10	# get Array[i][j]
		nop
		beq	$s0, 11, end		# exit
		
		li	$v0, 55
		la	$a0, ErrorWrongInput1	
		li	$a1, 2
		syscall
		j	PrintMenu
	End_of_menu:
	
	option1:
		la	$a0, Message6
		jal	ShowDialog
		nop
		add	$s0, $a0, $zero		# save input
		jal	LimitSize
		nop
		beqz	$a0, option1		# if wrong input
		nop
		la	$t0, charPtrLen
		sw	$s0, 0($t0)		# luu lai do dai CharPtr
		nop
		# Cap phat cho bien con tro
		la	$a0, CharPtr
		add	$a1, $zero, $s0
		addi	$a2, $zero, 1
		jal	Malloc
		nop
		# Cap phat cho bien con tro
		la	$a0, CharPtr2
		add	$a1, $zero, $s0
		addi	$a2, $zero, 1
		jal	Malloc
		nop
		j	PrintMenu
	option2:
		la	$a0, Message6
		jal	ShowDialog
		nop
		add	$s0, $a0, $zero		# save input
		jal	LimitSize
		nop
		beqz	$a0, option2		# if wrong input
		# Cap phat cho bien con tro
		la	$a0, BytePtr
		add	$a1, $zero, $s0
		addi	$a2, $zero, 1
		jal	Malloc
		nop
		j	PrintMenu
	option3:
		la	$a0, Message6
		jal	ShowDialog
		nop
		add	$s0, $a0, $zero		# save input
		jal	LimitSize
		nop
		beqz	$a0, option3		# if wrong input
		# Neu kieu du lieu can cap phat la Word
		# Kiem tra dia chi
		jal	FixWordAddress
		nop
		# Cap phat cho bien con tro
		la	$a0, WordPtr
		add	$a1, $zero, $s0
		addi	$a2, $zero, 4
		jal	Malloc
		nop
		j	PrintMenu
	option4:
		li	$v0, 4
		la	$a0, Message11
		syscall
		# lay gia tri con tro
		la	$a0, CharPtr
		jal	GetPtrValue
		move	$a0, $v0
		li	$v0, 34			# in duoi dang hexadecimal
		syscall
		li	$v0, 11
		li	$a0, ','
		syscall
		# lay gia tri con tro
		la	$a0, BytePtr
		jal	GetPtrValue
		move	$a0, $v0
		li	$v0, 34
		syscall
		li	$v0, 11
		li	$a0, ','
		syscall
		# lay gia tri con tro
		la	$a0, WordPtr
		jal	GetPtrValue
		move	$a0, $v0
		li	$v0, 34
		syscall
		
		j	PrintMenu
	option5:
		li	$v0, 4
		la	$a0, Message1
		syscall
		# lay dia chi con tro
		la	$a0, CharPtr
		li	$v0, 34
		syscall
		li	$v0, 11
		li	$a0, ','
		syscall
		# lay dia chi con tro
		la	$a0, BytePtr
		li	$v0, 34
		syscall
		li	$v0, 11
		li	$a0, ','
		syscall
		# lay dia chi con tro
		la	$a0, WordPtr
		li	$v0, 34
		syscall
		
		j	PrintMenu
	option6:
		# hien input string -->  CharPtr
		li	$v0, 54
		la	$a0, Message12
		la	$a1, stringBuff
		li	$a2, 109
		syscall
		# copy buff --> CharPtr
		la	$t1, stringBuff		# t1 : dia chi chuoi nguon
		la	$a0, CharPtr
		lw	$t2, 0($a0)		# t2 : dia chi chuoi dich
		la	$t0, charPtrLen
		lw	$s0, 0($t0)
		nop
		add	$t0, $zero, $zero	# t0 : bien dem cua vong lap
		op6_loop:
			slt	$t3, $s0, $t0	# kiem tra if t0 > s0
			beq	$t3, 1, op6_done	# --> done
			nop
			add	$t4, $t1, $t0	# dia chi charptr nguon vi tri t0
			add	$t5, $t2, $t0	# dia chi charptr dich vi tri t0
			lb	$t6, 0($t4)	# t6 = gia tri charptr nguon vi tri t0
			nop
			sb	$t6, 0($t5)	# gia tri charptr dich vi tri t0 = t6
			nop
			addi	$t0, $t0, 1	# tang bien dem cua vong lap
			j	op6_loop
		op6_done:
		# copy CharPtr vao CharPtr2
		la	$a0, CharPtr
		la	$a1, CharPtr2
		add	$a2, $zero, $s0
		add	$a3, $zero, $s0
		jal	CharPtrCpy
		nop
		beqz	$s4, next
		nop
		printResult:
			# hien thi chuoi nguon
			li	$v0, 4
			la	$a0, Message2
			syscall
			
			la	$a0, CharPtr
			jal	GetPtrValue
			move	$a0, $v0
			li	$v0, 4
			syscall
		
			# hien thi chuoi dich
			li	$v0, 4
			la	$a0, Message3
			syscall
				
			la	$a0, CharPtr
			jal	GetPtrValue
			move	$a0, $v0
			li	$v0, 4
			syscall
		next:
		j	PrintMenu
	option7:
		jal	TotalAllocatedMem
		move	$a1, $v0
		li	$v0, 56
		la	$a0, Message4
		syscall
		j	PrintMenu
	option8:
		la	$a0, Message7		# enter # rows
		jal	ShowDialog
		nop
		add	$s0, $a0, $zero		# luu so hang
		jal	LimitSize
		nop
		beqz	$a0, option8		# if wrong input
		
		la	$a0, Message8		# enter # columns
		jal	ShowDialog
		nop
		add	$s1, $a0, $zero		# luu so cot
		jal	LimitSize
		nop
		beqz	$a0, option8		# if wrong input
		# Neu kieu du lieu can cap phat la Word
		# Kiem tra dia chi
		jal	FixWordAddress
		nop
		# Cap phat cho bien con tro 2 chieu
		la	$a0, Word2Ptr
		add	$a1, $zero, $s0
		add	$a2, $zero, $s1
		jal 	Malloc2
		nop
		j	PrintMenu
	option9:
		op9_enterRow:
		la	$a0, Message7		# enter # rows
		jal	ShowDialog
		nop
		bltz	$a0, op9_enterRow		# neu so hang < 0
		nop
		la	$t0, row
		lw	$t1, 0($t0)
		bgt	$a0, $t1, op9_printErrorRow	# neu so hang lon hon row
		nop
		move	$s3, $a0		# luu so hang
		op9_enterCol:
		la	$a0, Message8		# enter # columns
		jal	ShowDialog
		nop
		bltz	$a0, op9_enterCol		# neu so hang < 0
		nop
		la	$t0, col
		lw	$t2, 0($t0)
		bgt	$a0, $t2, op9_printErrorCol	# neu so cot lon hon col
		nop
		move	$s4, $a0
		j	op9_next			# luu so cot
		op9_printErrorRow:
		li	$v0, 55
		la	$a0, ErrorOverSize
		li	$a1, 0
		syscall
		j	op9_enterRow
		op9_printErrorCol:
		li	$v0, 55
		la	$a0, ErrorOverSize
		li	$a1, 0
		syscall
		j	op9_enterCol	
		op9_next:
		la	$a0, Message9		# enter value
		jal	ShowDialog
		nop
		move	$s5, $a0
		# dat gia tri cho mang 2 chieu word
		la	$a0, Word2Ptr
		add	$a1, $zero, $t2
		add	$a2, $zero, $s3
		add	$a3, $zero, $s4
		add	$s1, $zero, $s5
		add	$s2, $zero, $t1
		jal	SetArray_i_j
		nop
		j	PrintMenu
	option10:
		op10_enterRow:
		la	$a0, Message7		# enter # rows
		jal	ShowDialog
		nop
		bltz	$a0, op10_enterRow		# neu so hang < 0
		nop
		la	$t0, row
		lw	$t1, 0($t0)
		bgt	$a0, $t1, op10_printErrorRow	# neu so hang lon hon row
		nop
		move	$s3, $a0		# luu so hang
		op10_enterCol:
		la	$a0, Message8		# enter # columns
		jal	ShowDialog
		nop
		bltz	$a0, op10_enterCol		# neu so hang < 0
		nop
		la	$t0, col
		lw	$t2, 0($t0)
		bgt	$a0, $t2, op10_printErrorCol	# neu so cot lon hon col
		nop
		move	$s4, $a0
		j	op10_next			# luu so cot
		op10_printErrorRow:
		li	$v0, 55
		la	$a0, ErrorOverSize
		li	$a1, 0
		syscall
		j	op10_enterRow
		op10_printErrorCol:
		li	$v0, 55
		la	$a0, ErrorOverSize
		li	$a1, 0
		syscall
		j	op10_enterCol	
		op10_next:
		# lay gia tri cua mang 2 chieu tai hang 1 cot 2
		la	$a0, Word2Ptr
		add	$a1, $zero, $t2
		add	$a2, $zero, $s3
		add	$a3, $zero, $s4
		add	$s2, $zero, $t1
		jal	GetArray_i_j
		nop
		move	$a1, $v0
		li	$v0, 56
		la	$a0, Message10
		syscall
		j	PrintMenu	
	
	
	j	end

end_main:
#----------------------------------------------------------------------------------------------------------------------------
# hien input dialog with menu
# @params[in]	a0 : address of menu string
#---------------------------------------------------------------------
ShowDialog:
	move	$t0, $a0
	li	$v0, 51		
	syscall
	beq	$a1, 0, exit
	nop
	beq	$a1, -1, PrintErrorWrongInput
	nop
	beq	$a1, -2, end
	nop
	beq	$a1, -3, PrintErrorNoInput
	nop
	PrintErrorWrongInput:
		li	$v0, 55
		la	$a0, ErrorWrongInput
		li	$a1, 0
		syscall
		j	next_step
	PrintErrorNoInput:
		li	$v0, 55
		la	$a0, ErrorNoInput
		li	$a1, 0
		syscall
		j	next_step
next_step:	
	move	$a0, $t0
	j	ShowDialog	
exit:	jr	$ra

# Lay gia tri cua con tro
# @param[in]	a0 : dia chi cua con tro
# @return	v0 : gia tri cua con tro
GetPtrValue:
	lw	$v0, 0($a0)
	nop
	jr	$ra
	
#----------------------------------------------------------------------------

# Ham khoi tao cho viec cap phat dong
# @param	khong co
# @detail	Danh dau vi tri bat dau cua vung nho co the cap phat duoc
SysInitMem:
	la	$t9, Sys_TheTopOfFree
	la	$t7, Sys_MyFreeSpace
	sw	$t7, 0($t9)
	nop
	la	$t6, TheTopOfMemSpace
	sw	$t7, 0($t6)
	nop
	la	$t6, WastedMemory
	add	$t5, $zero, $zero	# t5 : luu so o nho thua do fix
	sw	$t5, 0($t6)
	nop
	jr	$ra
	
# Ham cap phat dong bo nho dong cho cac bien con tro
# @param	$a0	chua dia chi cua bien con tro can cap phat
#			khi ket thuc, dia chi vung nho duoc cap phat se duoc luu vao bien con tro
# @param	$a1	So phan tu can cap phat
# @param	$a2	Kich thuoc 1 phan tu, tinh theo byte
# @return	$v0	Dia chi vung nho duoc cap phat
Malloc:
	la	$t9, Sys_TheTopOfFree
	lw	$t8, 0($t9)		# lay dia chi dau tien con trong
	nop
	sw	$t8, 0($a0)		# cat dia chi do vao bien con tro
	nop
	addi	$v0, $t8, 0		# la ket qua tra ve
	mul	$t7, $a1, $a2		# tinh kich thuoc cua mang can cap phat
	add	$t6, $t8, $t7		# tinh dia chi dau tien con trong
	sw	$t6, 0($t9)		# luu tro lai dia chi dau tien do vao bien Sys_TheTopOfFree
	nop
	jr	$ra

# lay dia chi free va kiem tra va lam cho no chia het cho 4
# @detail	kiem tra neu dia chi khong chia het cho 4 thi cong them de chia het cho 4
FixWordAddress:
	la	$t1, Sys_TheTopOfFree
	lw	$t2, 0($t1)
	nop
	andi	$t3, $t2, 0x3 		# t3 : so du khi chia dia chi cho 4
	bne	$t3, $zero, fix
	nop
	jr	$ra
	nop
	# cong them de dia chi chia het cho 4
	fix:
		addi	$t5, $zero, 4
		sub	$t4, $t5, $t3		# t4 : so can bu them cho dia chi
		add	$t2, $t2, $t4
		la	$t6, WastedMemory
		lw	$s6, 0($t6)
		nop
		add	$s6, $s6, $t4		# luu lai so o nho thua
		sw	$s6, 0($t6)
		nop
		sw	$t2, 0($t1)
		nop
		jr	$ra

# Ham copy 2 charptr
# @params[in]	a0 : dia chi cua charptr nguon
#		a1 : dia chi cua charptr dich
#		a2 : so phan tu cua charptr nguon
#		a3 : so phan tu cua charptr dich
# @return	s4 : 1 --> successfull | 0 --> error
# @detail: copy tung byte cua nguon sang dich
CharPtrCpy:
	blt	$a2, $a3, printError
	nop
	# copy
	lw	$t1, 0($a0)
	lw	$t2, 0($a1)
	add	$t0, $zero, $zero	# t0 : bien dem cua vong lap
	loop:
		slt	$t3, $a2, $t0	# kiem tra neu t0 > a2
		beq	$t3, 1, done	# --> done khi dat nguong do dai chuoi
		nop
		add	$t4, $t1, $t0	# dia chi charptr nguon vi tri t0
		add	$t5, $t2, $t0	# dia chi charptr dich vi tri t0
		lb	$t6, 0($t4)	# t6 = gia tri charptr nguon vi tri t0
		nop
		sb	$t6, 0($t5)	# gia tri charptr dich vi tri t0 = t6
		nop
		beq	$t6, '\0', done	# dung khi gap ki tu ket thuc chuoi
		nop
		addi	$t0, $t0, 1	# tang bien dem cua vong lap
		j	loop
	done:
		addi	$s4, $zero, 1
		j	continue
		nop
	printError:
		addi	$s4, $zero, 0
		li	$v0, 4
		la	$a0, ErrorMessage1
		syscall
	continue:
		jr	$ra
#----------------------------------------------------------------------------

# Tinh tong so bo nho da duoc cap phat
# @return	v0 : tong so bo nho da cap phat
# @detail : tong so bo nho da cap = dia chi cuoi - dia chi dau - so o nho thua
TotalAllocatedMem:
	la	$t1, Sys_TheTopOfFree
	lw	$t2, 0($t1)
	nop
	la	$t6, TheTopOfMemSpace
	lw	$s7, 0($t6)
	nop
	la	$t6, WastedMemory
	lw	$s6, 0($t6)
	nop
	sub	$t3, $t2, $s7
	sub	$v0, $t3, $s6		# tong bo nho da cap = dia chi cuoi - dia chi dau - so o nho thua
	jr	$ra
#------------------------------------------------------------------------------------

# cap phat dong cho mang 2 chieu word
# @params[in]	a0 : dia chi bien con tro can cap phat
#		a1 : so hang
#		a2 : so cot
# @return	v0 : dia chi dau tien cua vung nho duoc cap
# @detail : 
Malloc2:
	la	$t9, row		# luu lai so hang
	sub	$a1, $a1, 1
	sw	$a1, 0($t9)
	nop
	la	$t9, col		# luu lai so cot
	sub	$a2, $a2, 1
	sw	$a2, 0($t9)
	nop
	la	$t9, Sys_TheTopOfFree
	lw	$t8, 0($t9)		# lay dia chi dau cua vung nho
	nop
	sw	$t8, 0($a0)		# luu dia chi dau vao bien con tro
	nop
	addi	$v0, $t8, 0		# tra ve dia chi dau tien cua vung nho duoc cap
	mul	$t7, $a1, $a2		# t7 : so word can cap = so hang  * so cot
	sll	$t7, $t7, 2		# so byte can cap = t7 * 4
	add	$t6, $t8, $t7		# tinh dia chi dau tien con trong
	sw	$t6, 0($t9)		# luu lai dia chi dau tien con trong
	nop
	jr	$ra
#------------------------------------------------------------------------------------

# lay gia tri tai hang i cot j trong array
# @params[in]	a0 : dia chi cua bien con tro
#		a1 : so cot
#		a2 : hang i
#		a3 : cot j
#		s2 : so hang 
# @return	v0 : gia tri cua array tai hang i cot j
GetArray_i_j:
	lw	$t0, 0($a0)		# lay vi tri cua vung nho duoc cap cho con tro
	mul	$t1, $a1, $a2		
	add	$t1, $t1, $a3		# vi tri = i * so cot + j
	sll	$t1, $t1, 2		# t1 : so byte can cong them vao dia chi con tro
	add	$t2, $t1, $t0		# t2 : dia chi cua array tai hang i cot j
	lw	$v0, 0($t2)		# lay gia tri vao v0
	nop
	jr	$ra
#------------------------------------------------------------------------------------

# dat gia tri cho o tai hang i cot j
# @params[in]	a0 : dia chi cua bien con tro
#		a1 : so cot
#		a2 : hang i
#		a3 : cot j
#		s2 : so hang
#		s1 : gia tri muon dat cho array tai hang i cot j
SetArray_i_j:
	lw	$t0, 0($a0)		# lay vi tri cua vung nho duoc cap cho con tro
	mul	$t1, $a1, $a2		
	add	$t1, $t1, $a3		# vi tri = i * so cot + j
	sll	$t1, $t1, 2		# t1 : so byte can cong them vao dia chi con tro
	add	$t2, $t1, $t0		# t2 : dia chi cua array tai hang i cot j
	sw	$s1, 0($t2)
	nop
	jr	$ra
#------------------------------------------------------------------------------------
# Gioi han kich co cua vung nho cap phat la  [1, 1000]
# @params[in]	a0 : input
# @return	a0 = 0 : error | 1: error
LimitSize:
	blez	$a0, PrintErrorNegativeInput
	nop
	bge	$a0, 1000, PrintErrorTooLarge
	nop
	li	$a0, 1
	LS_continue:
	jr	$ra
	PrintErrorNegativeInput:
		li	$v0, 55
		la	$a0, ErrorNegativeInput
		li	$a1, 0
		syscall
		li	$a0, 0
		j	LS_continue	
	PrintErrorTooLarge:
		li	$v0, 55
		la	$a0, ErrorTooLarge
		li	$a1, 0
		syscall
		li	$a0, 0
		j	LS_continue
end:
