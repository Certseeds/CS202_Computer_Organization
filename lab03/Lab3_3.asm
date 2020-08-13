.include "macro_print_str.asm"
.data
    value: .word 0x00000000
    change: .asciiz "\n"
.text
main:
print_string("please input the integer x: ")
li $v0,5
syscall
sw $v0,value
lw $t0,value
lw $t1,value
sll $t0,$t0,3
sll $t1,$t1,1
add $a0,$t0,$t1
sw $a0,value
print_string("This is 10x: ")
li $v0,1
lw $a0,value
syscall


end
