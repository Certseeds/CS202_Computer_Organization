.include "macro_print_str.asm" 
.data 
space: .space 420
change: .asciiz "\n"
 .text 
jal main

end

main:
addi $t0,$zero,0
addi $t1,$zero,1
# la $t2,space
 #add $t2,$t2,$t0
 #sw $t1,0($t2)
loop:
    addi $t1,$t1,1
    addi $a0,$t1,0
    jal test_prime
    beq $v0,0,loop
    
    addi $t0,$t0,1
    sll $t0,$t0,2
    la $t2,space
    add $t2,$t2,$t0
    sw $t1,0($t2)
    srl $t0,$t0,2
    beq $t0,100,out
    j loop
out:
addi $t0,$zero,0
loop3:
addi $t0,$t0,1
sll $t0,$t0,2
la $t2,space
add $t2,$t2,$t0
lw $t1,0($t2)
addi $a0,$t1,0
li $v0,1
syscall
la $a0,change
li $v0,4
syscall
srl $t0,$t0,2
beq $t0,100,out2
j loop3

out2:
jr $ra

test_prime:
#传进来的值是$a0
addi $t3,$zero,1
addi $t5,$a0,-1
addi $v0,$zero,1
beq $a0,2,return_test_prime
loop2:
    addi $t3,$t3,1
    div $a0,$t3
    mfhi $t4
    beq $t4,0,success
    beq $t3,$t5,return_test_prime
    blt $t3,$t5,loop2
success:    
addi $v0,$zero,0
jr $ra
return_test_prime:
jr $ra








