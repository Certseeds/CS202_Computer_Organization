.data
        printa : .asciiz "Please input integer A\n"
        a: .word 0
        printb : .asciiz "Please input integer B\n"
        b: .word 0
        printc : .asciiz "Please input integer C\n"
        c: .word 0
        printd : .asciiz "Please input integer D\n"
        d: .word 1
        Quotient : .asciiz "Quotient:"
        remainder : .asciiz "remainder:"
        nextLine: .asciiz "\n"
        # in their don't consider that b*c+a will bigger than max value of 32bit
        numberOfMyself : .asciiz "1145141\n"
        nameOfMyself : .asciiz "YeShouXianB\n"
.text
main:
    li $v0,4
    la $a0,printa
    syscall
    li $v0,5
    syscall
    sw $v0,a
    
    li $v0,4
    la $a0,printb
    syscall
    li $v0,5
    syscall
    sw $v0,b
    
    li $v0,4
    la $a0,printc
    syscall
    li $v0,5
    syscall
    sw $v0,c
    
    li $v0,4
    la $a0,printd
    syscall
    li $v0,5
    syscall
    sw $v0,d
    
    lw $t0,b
    lw $t1,c
    mult $t0,$t1
    mflo $t0 
    lw $t1,a 
    add $t0,$t0,$t1
    lw $t1,d
    div $t0,$t1
    
    la $a0,Quotient
    li $v0,4
    syscall
    
    mflo $a0
    li $v0,1
    syscall
    
    
    la $a0,nextLine
    li $v0,4
    syscall 
    
    la $a0,remainder
    syscall
    li $v0,1
    mfhi $a0
    syscall
    
    la $a0,nextLine
    li $v0,4
    syscall 
    
    la $a0,numberOfMyself
    syscall
    la $a0,nameOfMyself
    
    syscall
      
    li $v0,10
    syscall

