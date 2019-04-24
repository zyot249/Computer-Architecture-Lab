     

      .data
      array:  .word 0:50 
strintro:  .asciiz "\nThis program will read an interger from the keyboard and convert it to its hexadecimal value. Upon exit the program will print the corresponding string of hexadecimal characters.\n"

strin:  .asciiz "\nPlease enter a positive interger:  "
strhex:  .asciiz "\nThe string of hex characters:  "
strnl:  .asciiz "\n"

      .text
main:        addi $t1, $0, 9        
      addi $t3, $0, 1             
      la $s0, array            
      li $v0, 4            
      la $a0, strintro      
      syscall                  

read:        li $v0, 4            
      la $a0, strin            
      syscall                  

      li $v0, 5            

      syscall                  

      slt $t2, $v0, $t1       
      beq $t2, $t3, equal
      bne $t2, $t3, check

equal:       sw $v0, 0($s0)          
      addi $s0, $s0, 4      
      j read

check:      slti $t4, $v0, 15      
      bne $t4, $0, convert      

convert:  #I know I need to compare the 4 LSB's from each number but should I convert to binary first and when I compare 
              #do I need a series of if tests to print the hex character.
