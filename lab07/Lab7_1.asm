.data
word1: .asciiz "student"
word2: .asciiz "'s grade:  "
array: .space 300
#4*5*10 + 冗余
array2: .space 50
value0: .float 0
value1: .float 5
value10: .float 10
space: .asciiz " "
temp: .word 0
change: .asciiz "\n"
.text
addi $t0,$zero,0
la $t1,array
loop1:
    addi $t0,$t0,1
    la $a0,word1
    li $v0,4
    syscall
    addi $a0,$t0,0
    li $v0,1
    syscall
    la $a0,word2
    li $v0,4
    syscall
        li $a0,0
        li $a1,11
    addi $t2,$zero,0
    loop2:
        addi $t1,$t1,4
        addi $t2,$t2,1
       # li $v0,6
        li $v0,42
        syscall
        li $v0,1
        syscall
        sw $a0,temp
        la $a0,space
        li $v0,4
        syscall
        lwc1 $f0,temp
        cvt.s.w $f0,$f0
        swc1 $f0,0($t1)
        bne $t2,10,loop2
      la $a0,change
      li $v0,4
      syscall
bne $t0,5,loop1

la $t1,array
la $t2,array2
addi $t4,$zero,10
addi $t3,$zero,-36
loop3:
    addi $t5,$t3,0
    lwc1 $f7,value0
    addi $t2,$t2,4
    loop4:
        addi $t3,$t3,40
        add $t6,$t3,$t1
        lwc1 $f8,0($t6)
        add.s $f7,$f7,$f8
        ble $t3,160,loop4
     swc1 $f7,0($t2)
     addi $t3,$t5,4
bne $t3,4,loop3

la $t0,array2
addi $t1,$zero,0
addi $t3,$zero,0
lwc1 $f0,value0
lwc1 $f1,value1
 loop5:
     addi $t1,$t1,4
     add $t2,$t1,$t0
     l.s  $f0,0($t2)
     div.s $f0,$f0,$f1
     add.s $f4,$f4,$f0
     s.s $f0,0($t2)
     bne $t1,40,loop5
 #这个循环之后,array2中存放着每个lab的平均值,$f4中存放着平均值之和
 lwc1 $f2,value10
 div.s $f4,$f4,$f2
 
la $t0,array2 
addi $t1,$zero,0

loop6:
 addi $t1,$t1,1
 sll $t1,$t1,2
 add $t2,$t1,$t0
 srl $t1,$t1,2
 lwc1 $f0,0($t2)
 c.lt.s 0,$f4,$f0
 bc1t 0,next
 addi $a0,$t1,0
 li $v0,1
 syscall
 la $a0,space
 li $v0,4
 syscall
 next:
 bne $t1,10,loop6
     
li $v0,10
syscall
