.data
precison: .word 0
valueInput: .double 0
value0: .double  0
value1: .double  1
value2: .double 2
value10: .double  10
valueN1: .double -1
.text
l.d $f0,value10

     
li $v0,10
syscall
