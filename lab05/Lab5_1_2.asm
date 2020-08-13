.include "macro_print_str.asm"
.data
    begin: .asciiz "Input the n: "
    final: .asciiz "that is output: "
.text
main:
la $a0,begin
addi $v0,$zero,4
syscall
addi $v0,$zero,5
syscall
addi $t2,$zero,0
addi $t3,$zero,0
addi $a0,$v0,0
addi $v0,$zero,0
jal fib
add $v1,$v0,$zero
la $a0,final
addi $v0,$zero,4
syscall
addi $a0,$v1,0
li $v0,1
syscall
end

fib:
    addi $sp,$sp,-8
    sw $ra,4($sp)
    sw $a0,0($sp)
    sle $t0,$a0,0
    #a0<=0,$t0 =1
    beq $t0,$zero,Zero
    addi $v0,$v0,0
    addi $sp,$sp,8
    jr $ra
    #到此说明a0>0
    Zero:
    sle $t0,$a0,1
    #a0<=1,$t0 =1
    beq $t0,0,One
    add $v0,$v0,1
    addi $sp,$sp,8
    jr $ra
    One:
        addi $a0,$a0,-1
        jal fib
        lw $a0,0($sp)
        lw $ra,4($sp)
        addi $sp,$sp,8
        addi $a0,$a0,-2
        addi $sp,$sp,-8
        sw $ra,4($sp)
        sw $a0,0($sp)
        jal fib 
        lw $a0,0($sp)
        lw $ra,4($sp)
        addi $sp,$sp,8
        jr $ra         

