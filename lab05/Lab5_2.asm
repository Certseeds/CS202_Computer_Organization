.include "macro_print_str.asm" 
.data 
begin: .asciiz "Input an integer: "
middle: .asciiz "invalid Entry"
final: .asciiz "That is output: "
zero_0: .asciiz "Zero"
zero_1: .asciiz "One"
zero_2: .asciiz "Two"
zero_3: .asciiz "Three"
zero_4: .asciiz "Four"
zero_5: .asciiz "Five"
zero_6: .asciiz "Six"
zero_7: .asciiz "Seven"
zero_8: .asciiz "Eight"
zero_9: .asciiz "Nine"
zero_10: .asciiz " "
zero_11: .asciiz "."
space: .space 40
constant: .word 10
 .text main:
lw $t4,constant
la $a0,begin
addi $v0,$zero,4
syscall
addi $v0,$zero,5
syscall
ble $v0,0,output_middle
addi $t5,$zero,-1
loop:
    addi $t5,$t5,1
    div $v0,$t4
    
    mfhi $t1
    la $t3,space
    add $t3,$t3,$t5
    sb $t1,0($t3)
    
    mflo $t2
    add $v0,$t2,$zero
    bne $t2,$zero,loop

loop2:
    la $t3,space
    add $t3,$t3,$t5
    lb $t1,0($t3)
    beq $t1,0,Zero
    beq $t1,1,One 
    beq $t1,2,Two
    beq $t1,3,Three
    beq $t1,4,Four
    beq $t1,5,Five  
    beq $t1,6,Six
    beq $t1,7,Seven   
    beq $t1,8,Eight
    beq $t1,9,Nine 
    Nine:
    la $a0,zero_9
    j output_begin
    Eight:
    la $a0,zero_8
    j output_begin
    Seven:
    la $a0,zero_7
    j output_begin
    Six:
    la $a0,zero_6
    j output_begin
    Five:
    la $a0,zero_5
    j output_begin
    Four:
    la $a0,zero_4
    j output_begin
    Three:
    la $a0,zero_3
    j output_begin
    Two:
    la $a0,zero_2
    j output_begin
    One:
    la $a0,zero_1
    j output_begin
    Zero:
    la $a0,zero_0
    j output_begin
    
    output_begin:
    addi $v0,$zero,4
    syscall
    
    addi $t5,$t5,-1
    beq $t5,-1,jump_out
    la $a0,zero_10	
    syscall
    j loop2
 jump_out:   
 la $a0,zero_11
 syscall
 j end_before

output_middle:
la $a0,middle
addi $v0,$zero,4
syscall
end_before:
end
