.data
.text
	Loop:
	addi $v0,  $zero, 5
	syscall
	
	add $a0, $v0, $zero
	srl $a2, $a0, 16
	andi $s1, $a2, 1
	srl $a2, $a2, 1
	and $s2, $a2, 1
	srl $a2, $a2, 1
	and $s3, $a2, 1
	beq $s3, 1, first_bit_one

	beq $s2, 1, first_zero_second_one
	beq $s1, 1, zzo
	zzz:
	sll $s4, $a0, 24
	srl $s4, $s4, 24
	sll $s5, $a0, 16
	srl $s5, $s5, 24
	j Loop
	
	
	first_zero_second_one:
	beq $s1, 0, zoz
	
	zoo:
	add $s6, $s5, $zero
	add $v1, $s4, $zero
	judge:
	slti $s7, $s6, 1
	beq $s7, 0, shift_left 
	jal output
	j  Loop
	
	shift_left:
	sll $v1, $v1, 1
	addi $s6, $s6, -1
	j judge
	
	first_bit_one: 
	beq $s2, 0, first_one_second_zero
	beq $s1, 0, ooz
	xor $v1, $s4, $s5
	jal output
	j  Loop
		
	
	first_one_second_zero:
	beq $s1, 0, ozz
	
	ozo:
	slt $s6, $s5, $s4
	beq $s6, 1, bigger 
	addi $v1, $zero, 0
	jal output 
	j  Loop
	
	bigger:
	addi $v1, $zero, 1
	j Loop
	
	
	ozz: 
	add $s6, $s5, $zero
	add $v1, $s4, $zero
	judge_2:
	slti $s7, $s6, 1
	beq $s7, 0, shift_right 
	jal output
	j  Loop
	
	shift_right:
	srl $v1, $v1, 1
	addi $s6, $s6, -1
	j judge_2
	
	ooz:
	and $v1, $s4, $s5
	jal output
	j  Loop
	
	zoz:
	sub  $v1, $s4, $s5
	jal output
	j  Loop
	
	zzo:
	add $v1, $s4, $s5
	jal output
	j  Loop
	
	output:
	add $a0, $v1, $zero
	addi $v0, $zero, 1
	syscall 
	jr $ra