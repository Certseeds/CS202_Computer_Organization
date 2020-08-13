.include "macro_print_str.asm" 
.data 
begin: .asciiz "Input the n: "
final: .asciiz "that is output: "
 .text main:
la $a0,begin
addi $v0,$zero,4
syscall
addi $v0,$zero,5
syscall
add $t0,$v0,$zero
beq $t0,0,zero
beq $t0,1,One
addi $t1,$zero,0
addi $t2,$zero,1
addi $t3,$zero,0
addi $t4,$zero,1
j fib_loop
zero:
addi $t3,$zero,0
j output
One:
addi $t3,$zero,1
j output
fib_loop:
    add $t3,$t2,$t1
    add $t1,$t2,$zero
    add $t2,$t3,$zero
    addi $t4,$t4,1
    bne $t4,$t0,fib_loop
output:
    la $a0,final
    addi $v0,$zero,4
    syscall
    addi $a0,$t3,0
    addi $v0,$zero,1
    syscall
end

