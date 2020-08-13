.include "macro_print_str.asm"
.data
    tdata: .word 0xff00ff00
    before :.byte 0x00
    after: .byte 0x00
.text
main:
print_string("please input an integer : ")
li $v0,5
syscall
sw $v0,tdata
print_string("This is input number: ")
lw $a0,tdata
li $v0,34
syscall
lw $a0,tdata
li $v0,34
sb $a0,before
lbu $a0,before 
lw $a0,tdata
sra $a0,$a0,24
sb $a0,after
sra $a0,$a0,8
lbu $a0,after
li $v0,34


lw $a0,tdata
sll $a0,$a0,8
li $v0,34
sw $a0,tdata
print_string("\nThe output is:")
lbu $t0,before
la,$a0,tdata
sb $t0,($a0)
lw $a0,tdata
li $v0,34
ror $a0,$a0,8
li $v0,34
sw $a0,tdata
lbu $t1,after
la $a0,tdata
sb $t1,($a0)
lw $a0,tdata
li $v0,34
syscall


end
