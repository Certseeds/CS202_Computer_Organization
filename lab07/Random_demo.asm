.data
word1: .asciiz "input student"
word2: .asciiz "'s grade:"
array: .space 300
#4*5*10 + ศ฿ำเ
array2: .space 50
value0: .float 0
value1: .float 5
value10: .float 10
space: .asciiz " "
temp: .word 0
.text
addi $t0,$zero,0
la $t1,array
loop1:
    addi $t0,$t0,1
       
    addi $t2,$zero,0
    loop2:
        addi $t1,$t1,4
        addi $t2,$t2,1
       # li $v0,6
        li $a0,0
        li $a1,10
        li $v0,42
        syscall
        
        li $v0,1
        syscall
        la $a0,space
        li $v0,4
        syscall
        sw $a0,temp
        lwc1 $f0,temp
        cvt.s.w $f0,$f0
        swc1 $f0,0($t1)
        bne $t2,10,loop2
bne $t0,5,loop1


li $v0,10
syscall
