.include "macro_print_str.asm"
.data
    times: .word 0x00000010
    count: .word 0x00000000
    value: .word 0x00000000
    change: .asciiz "\n"
.text
main:
#produce 0x00000002
nor $t2,$zero,$zero
srl $t2,$t2,31
sll $t2,$t2,1
#now $t2 is 0x00000002

print_string("please input the integer : ")
li $v0,5
syscall
sw $v0,value
lw $t0,times
lw $t1,count
lw,$t3,value
loop:
    xor $t3,$t3,$t2
    ror $t3,$t3,2
    addi $t1,$t1,1
    sw $t1,count
    
  #  lw $a0,count
  # li $v0,1
  # syscall
  # la $a0,change
  # li $v0,4
  # syscall 
    
    beq $t0,$t1,Exit
    j loop
Exit:

print_string("This is the output integer: ")
sw $t3,value
lw $a0,value
li $v0,1
syscall
end
