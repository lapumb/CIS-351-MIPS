.text

#Blake Lapum
#CIS 351-02
#Winter 2018

main:
	addi $a0, $0, 3 #a
	addi $a1, $0, 7 #b
	addi $a2, $0, 2 #c
	add $a3, $0, $a0 #i = a
	addi $s0, $0, 0 #sum = 0
	
	addi $sp, $sp, -4 #storing initial return address
	sw $ra, 0($sp)
	
	jal wackySum
	
	# Restore from the stack.
	lw $ra, 0($sp)
	addi $sp, $sp, 4
		
	jr $ra #ends program
	
wackySum:
	bgt $a3, $a1, done #check if condition is initially met
	
	# Store on the stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal combineFour
	
	# Restore from the stack.
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra #return adress(main)
	
combineFour:
	addi $sp, $sp, -16
	sw $ra, 0($sp) 
	sw $a1, 4($sp) #adding condition to the stack
	sw $a2, 8($sp) #adding increment to the stack
	sw $a3, 12($sp) #adding i to the stack
	addi $t0, $0, 2 #divider
	addi $a0, $a3, 0 #i
	addi $a1, $a3, 1
	div $a1, $a1, 2 #(i+1)/2
	addi $a2, $a3, 2
	div $a2, $a2, 2 #(i+2)/2
	addi $a3, $a3, 3 #i+3
	add $t1, $a0, $a1
	add $t1, $t1, $a2
	add $t1, $t1, $a3 #sum of arguments
	div $t1, $t0
	mfhi $t2 #remainder of sum/2
	beq $t2, 0, resume #if remainder=0
	div $t1, $t1, 2 #else sum/2
	j resume

resume:
	addi $v0, $t1, 0 #sum after combineFour
	lw $ra, 0($sp)
	lw $a1, 4($sp) #restoring condition from stack
	lw $a2, 8($sp) #restoring increment from stack
	lw $a3, 12($sp) #restoring i from stack
	addi $sp, $sp, 16 #restoring stack
	add $a3, $a3, $a2 #increasing i by c
	add $s0, $s0, $v0 #adding returned value to running sum
	bgt $a3, $a1, done #check if condition is met
	blt $a3, $a1, combineFour #else if i < or
	beq $a3, $a1, combineFour # = b, go to combineFour
	jr $ra #return to caller (wackysum)

done: 
	addi $v0, $s0, 0 #total sum to return register
	jr $ra #return to caller (after jal wackySum in main)
