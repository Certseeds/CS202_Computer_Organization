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
srl $t0,$t0,31
lw $t1,value
bne $t0,0,Else
j Exit
Else:
not $t1,$t1
addiu $t1,$t1,1
Exit:

print_string("The absolute value of x is: ")

sw $t1,value
lw $a0,value
li $v0,36
syscall
end
