.data
        a: .word 3
        b: .word 4
        c: .word 5
        d: .word 7
        nextLine: .asciiz "\n"
        Quotient : .asciiz "Quotient:"
        remainder : .asciiz "remainder:"
        # in their don't consider that b*c+a will bigger than max value of 32bit
        numberOfMyself : .asciiz "1145141\n"
        nameOfMyself : .asciiz Yeshouxianb\n"
.text
main:
    lw $t0,b
    lw $t1,c
    mult $t0,$t1
    mflo $t0 #µÍÎ»µ½t0,ÏÈºöÂÔ¸ßÎ»
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

