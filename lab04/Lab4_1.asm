.include "macro_print_str.asm"
.data
    array: .space, 400
    str: .asciiz"\nthose are t :\n"
    change: .asciiz  "\n"
    final: .asciiz "this is the number of t: "
.text
main:
   la $a0,str
   li $v0,4
   syscall
addi $t0,$zero,0
addi $t2,$zero,0
addi $s3,$zero,0
loop1:
    addi $t0,$t0,1
    addi $t1,$zero,0
    loop2:
        addi $t1,$t1,1
        addi $t2,$zero,0
        loop3:
            addi $t2,$t2,1
            addi $s3,$s3,1
            #
            mult $t0,$t0
            mflo $t3
            mult $t1,$t1
            mflo $t4
            add $t7,$t3,$t4
            #
            mult $t2,$t2
            mflo $t3
            mult $t0,$t1
            mflo $t4
            add $t7,$t7,$t3
            add $t7,$t7,$t4
            #
            mult $t1,$t2 
            mflo $t3
            mult $t2,$t0
            mflo $t4
            add $t7,$t7,$t3
            add $t7,$t7,$t4
            #
            slti $t3,$t7,400
            #小于400就等于$t3 == 1,不等于1就大于400,需要跳过
          #add $a0,$zero,$t7
           #li $v0,1
           #syscall
          # la $a0,change
          # li $v0,4
          # syscall
            bne $t3,1,jump
                la $t5,array
                add $t5,$t5,$t7
                sb $t3,0($t5)
            jump:
            bne $t2,20,loop3
        bne $t1,20,loop2
    bne $t0,20,loop1
la $s0,array
addi $t6,$zero,0
addi $t5,$zero,0
loop4:
    addi $t6,$t6,1
    addi $s0,$s0,1
    lb $s1,($s0)
    bne $s1,1,jump2
        move $a0,$t6
        li $v0,1
        syscall
        la $a0,change
        li $v0,4
        syscall
        addi $t5,$t5,1
    jump2:
    bne $t6,400,loop4
la $a0,final
li $v0,4
syscall   
move $a0,$t5
li $v0,1
syscall    
    

end
