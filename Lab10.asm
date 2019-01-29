.text
.globl nCk

# a0 is n
# a1 is k

nCk:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal recurs
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
recurs:
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	# Temporary variables
	add $s0, $a0, $0 # s0 = n
	add $s1, $a1, $0 # s1 = k
	
	# t1 = 1
	addi $t1, $0, 1
	
	blt $s0, $s1, invalid
	beq $s1, $0, kiszero
	beq $s1, $t1, kisone
	beq $s0, $s1, kisn
	
	# n - 1
	addi $a0, $s0, -1
	
	jal recurs
	
	# n - 1
	addi $a0, $s0, -1
	# k - 1
	add $s2, $0, $v0
	addi $a1, $s1, -1
	
	jal recurs
	
	add $v0, $v0, $s2
	
exit:
	lw $ra, 0($sp)       
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16     
	jr $ra	
kiszero:
	li $v0, 1
	j exit
kisone:
	addi $v0, $s0, 0
	j exit
kisn:
	li $v0, 1
	j exit
invalid:
	li $v0, -1
	j exit
	
	
	
