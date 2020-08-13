.data
word1: .asciiz "input a positive number: "
word2: .asciiz "Please input a positive number!"
word3: .asciiz "Please input the precison value:"
precison: .word 0
valueInput: .double 0
value0: .double  0
value1: .double  1
value2: .double 2
value10: .double  10
valueN1: .double -1
.text
la $a0,word1
li $v0,4
syscall
li $v0,7
syscall
s.d $f0,valueInput
l.d $f2,value0
c.lt.d 0,$f0,$f2
bc1t 0,end1
la $a0,word3
li $v0,4
syscall
li $v0,7
syscall
mov.d $f4,$f0
l.d $f0,valueInput

#addi $t1,$v0,0
#l.d $f4,value1
#l.d $f6,value10
#loop1:
#    addi $t1,$t1,-1
#    div.d $f4,$f4,$f6
#    bne $t1,0,loop1

l.d $f8,value1
l.d $f10,value2
l.d $f12,valueN1
mul.d $f12,$f4,$f12
#0是起始值,2是0,4,12都是精度值,6中间变量,8是循环变量,10是2,
loop2:
    div.d $f6,$f0,$f8
    add.d $f8,$f6,$f8
    div.d $f8,$f8,$f10
    mul.d $f14,$f8,$f8
    sub.d $f14,$f14,$f0
    c.lt.d 0,$f14,$f12
    bc1t 0,loop2 
    c.lt.d 1,$f4,$f14
    bc1t 1,loop2
add.d $f12,$f8,$f2
li $v0,3
syscall
j end2

end1:
la $a0,word2
li $v0,4
syscall
j end2

end2:

     
li $v0,10
syscall

