.globl indexOf max sum13 sum67
.text

# Logun DeLeon
# Ryan Eisenbarth
# BLAKE LAPUM!!!

# ALSO BLAKE LAPUM

sum13:
	add $t0, $zero, $zero # sum = 0
	add $t1, $zero, $zero # i = 0
	add $t2, $zero $a1 # set limit for loop
	add $t3, $a0, $zero # temp array
for:
	beq $t1, $t2, done # exit loop
	lw $t4, 0($t3) # array[i]
	beq $t4, 13, equal13 # if  (array[i] == 13)
	add $t0, $t0, $t4 # sum += array[i]
	addi $t1, $t1, 1 # i++
	sll $t5, $t1, 2 # i * 4
	add $t3, $a0, $t5 # next word in array
	j for
equal13:
	addi $t1, $t1, 1 # i += 1
	beq $t1, $t2, done # exit loop
	addi $t1, $t1, 1 # i += 1
	sll $t5, $t1, 2 # i * 4
	add $t3, $a0, $t5 # add i * 4 to get to next word (skipping one word)
	j for
done:
	add $v0, $t0, $zero
	jr $ra


sum67:
	add $t0, $zero, $zero # sum = 0
	add $t1, $zero, $zero # i = 0
	add $t2, $zero $a1 # set limit for loop
	add $t3, $a0, $zero # temp array
	add $t6, $zero, $zero # is a six section
for2:
	beq $t1, $t2, done2
	lw $t4, 0($t3)
	beq $t4, 6, equal6
	beq $t6, 1, sixSection
	add $t0, $t0, $t4
	addi $t1, $t1, 1 # i++
	sll $t5, $t1, 2 # i * 4
	add $t3, $a0, $t5 # next word in array
	j for2
equal6:
	addi $t6, $zero, 1
	addi $t1, $t1, 1 # i++
	sll $t5, $t1, 2 # i * 4
	add $t3, $a0, $t5 # next word in array
	j for2
sixSection:
	beq $t4, 7, equal7
	addi $t1, $t1, 1 # i++
	sll $t5, $t1, 2 # i * 4
	add $t3, $a0, $t5 # next word in array
	j for2
equal7:
	add $t6, $zero, $zero
	addi $t1, $t1, 1 # i++
	sll $t5, $t1, 2 # i * 4
	add $t3, $a0, $t5 # next word in array
	j for2
done2:
	add $v0, $zero, $t0
	jr $ra


max:
    addi $t0, $a1, 0  #size of array
    add $s0, $a0, $0  #address of array
    add $s1, $s0, $0 #temp array
    addi $t1, $0, 0 #index
    lui $t3, 0xffff  # max
    ori $t3, $t3, 0xffff
    
for3:
    beq $t1, $t0, done3
    lw $t2, 0($s1)
    bge $t2, $t3, bigger    
continue:
    addi $s1, $s1, 4
    addi $t1, $t1, 1
    j for3
bigger:
    add $t3, $t2, $zero
    j continue
done3:
    add $v0, $t3, $zero
    jr $ra





indexOf:
    addi $t0, $a0, 0  #value
    add $s0, $a1, $0  #address of array
    add $s1, $s0, $0 #temp array
    addi $t1, $0, 0 #index
    addi $t2, $0, 0 # end condition
    addi $t3, $0, 0  # our value
    addi $t5, $zero, 1  #one
    addi $t6, $zero, -1
   
   
while:
	beq  $t2, $t5, end
        lw $t4, 0($s1)
        addi $t3, $t4, 0
        beq  $t3, $t0, equal
        ble  $t3, $t6, end
        add $s1, $s1, 4
        addi $t1, $t1, 1
        j while
equal:
        addi $t2, $t2, 1
        add $t6, $t1, $zero
        j while
end:
        addi $v0, $t6, 0
        jr $ra
