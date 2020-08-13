.data
word1: .asciiz "input student"
word2: .asciiz "'s grade:"
array: .space 100
array2: .space 50
value0: .float 0
value1: .float 5
value10: .float 10
space: .asciiz " "
.text
li $v0,6
li $v1,5
add $t0,$v0,$v1

     
li $v0,10
syscall
