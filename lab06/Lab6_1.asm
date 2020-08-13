.data 
 first: .asciiz "\nWelcome to use the simple arithmetic calculator on unsigned 31bit number: "
 second: .asciiz "\nPlease input operator:"
 third: .asciiz "\nPlease input addend: "
 thirdOne: .asciiz "\nPlease input augend: "
 thirdTwo: .asciiz "\nPlease input multiplicand : "
 thirdThird: .asciiz "Please input multiplier : "
 sixth: .asciiz "The "
 seventh: .asciiz "sum "
 sevenPoint: .asciiz "product "
 eighth: .asciiz " of "
 ninth: .asciiz " and "
 tenth: .asciiz " is: "
 dmsg: .asciiz "\ndata over" 
.text 
main: 
la $a0,first
li $v0,4
syscall
la $a0,second
syscall
li $v0,12
syscall
addi $t0,$v0,0
#·ûºÅ´æµ½t0Àï
beq $t0,0x0000002b,Plus
beq $t0,0x0000002a,multiply 
tnei $t0,0xffffffff
j end2
Plus:
la $a0,third
li $v0,4
syscall
li $v0,5
syscall
addi $t1,$v0,0
la $a0,thirdOne
li $v0,4
syscall
la $v0,5
syscall
addi $t2,$v0,0
addu $t3,$t2,$t1
srl $t3,$t3,31
    teqi $t3,1 
    beq $t3,1,end2

la $a0,sixth
li $v0,4
syscall
la $a0,seventh
li $v0,4
syscall
la $a0,eighth
li $v0,4
syscall
addi $a0,$t1,0
li $v0,1
syscall
la $a0,ninth
li $v0,4
syscall
addi $a0,$t2,0
li $v0,1
syscall
la $a0,tenth
li $v0,4
syscall
addu $a0,$t1,$t2
li $v0,1
syscall
j end2

multiply:
la $a0,thirdTwo
li $v0,4
syscall
li $v0,5
syscall
addi $t1,$v0,0

la $a0,thirdThird
li $v0,4
syscall
la $v0,5
syscall
addi $t2,$v0,0
multu $t1,$t2
mfhi $t3
       tnei $t3,0
       bne $t3,0,end2

la $a0,sixth
li $v0,4
syscall
la $a0,sevenPoint
li $v0,4
syscall
la $a0,eighth
li $v0,4
syscall
addi $a0,$t1,0
li $v0,1
syscall
la $a0,ninth
li $v0,4
syscall
addi $a0,$t2,0
li $v0,1
syscall
la $a0,tenth
li $v0,4
syscall
mflo $a0
li $v0,1
syscall

end2:
li $v0,10
syscall

.ktext  0x80000180
beq $t0,0x0000002a,HandleMulti
beq $t0,0x0000002b,HandlePlus
la $a0,thirdZero
li $v0,4
syscall
sw $t0,operation
la $a0,operation
li $v0,4
syscall
la $a0,thirdZeroHalf
li $v0,4
syscall
mfc0 $a0,$14
addi $a0,$a0,4
mtc0 $a0,$14
eret

HandlePlus:
la $a0,fourth
li $v0,4
syscall
mfc0 $a0,$14
addi $a0,$a0,-8
li $v0,34
syscall
addi $a0,$a0,12
mtc0 $a0,$14
la $a0,fifth
li $v0,4
syscall
eret
HandleMulti:
la $a0,fourth
li $v0,4
syscall
mfc0 $a0,$14
addi $a0,$a0,-8
li $v0,34
syscall
addi $a0,$a0,12
mtc0 $a0,$14
la $a0,fifthPoint
li $v0,4
syscall
eret
           
.kdata
 fourth: .asciiz "\nRuntime exception at "
 fifth: .asciiz ",the sum is overflow "
 fifthPoint: .asciiz ",the product is bigger than the Max value of a word "
 thirdZero: .asciiz "\nThe operator "
 operation: .word 0x00000000
 thirdZeroHalf: .asciiz " is not supported ,exit "