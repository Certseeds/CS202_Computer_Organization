.data
        printa : .asciiz "abc"
        nextLine: .asciiz "\n"
        test : .asciiz "test"
        firstSentence: .asciiz "Before:"
        secondSentence : .asciiz "After: "
.text
main:
    li $v0,4
    
    la, $a0,firstSentence
    syscall
    la $a0,printa
    syscall
    #print "abc" and then begin to do action to transform it to "ABC"
    
    la $a0,nextLine
    syscall
    la $a0,secondSentence
    syscall
    
    la $a0,printa
    
    lb $t0,($a0)
    lb $t1,1($a0)
    lb $t2,2($a0)
    subu $t0,$t0,32
    subu $t1,$t1,32
    subu $t2,$t2,32    
    sb $t0,($a0)
    sb $t1,1($a0)
    sb $t2,2($a0)
    syscall
      
    li $v0,10
    syscall

