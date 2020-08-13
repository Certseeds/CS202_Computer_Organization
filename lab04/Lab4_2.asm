.include "macro_print_str.asm"
.data
    begin: .asciiz "input a string no longer than 400 characters: "
    after: .asciiz "This is output: "
    array: .space 402
    change: .asciiz "\n"
.text
main:
la $a0,begin
li $v0,4
syscall
la $a0,array
la $a1,401
li $v0,8
syscall

la $t0,array
subi $t0,$t0,1
addi $t2,$zero,0  
loop1:
    addi $t2,$t2,1
    addi $t0,$t0,1
    lb $t1,0($t0)
    bne $t1,0,loop1
la $t0,array
subi $t2,$t2,2
sra $t3,$t2,1
subi $t3,$t3,1
addi $t4,$zero,0
subi $t4,$t4,1
addi $t5,$zero,0
loop2:
    add $t6,$zero,$t0
    addi $t4,$t4,1
    add  $t5,$t0,$t4
    add $t6,$t6,$t2
    subi $t6,$t6,1
    sub $t6,$t6,$t4
    lb $s0,0($t5)
    lb $s1,0($t6)
    sb $s0,0($t6)
    sb $s1,0($t5)
    bne $t4,$t3,loop2
la $a0,after
li $v0,4
syscall
la $a0,array
syscall    
    

end
