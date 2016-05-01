	.text
	.globl main
main:
	li	$v0, 4				#print pattern choose
	la	$a0, pattern
	syscall
        li	$v0, 5				#input pattern choose
        syscall
        move $s0, $v0				#$s0 = pattern
        li	$v0, 4				#print size input
        la	$a0, size
        syscall
        li	$v0, 5				#input size
        syscall
        move $s1, $v0				#$s1 = size
        li	$t0, 1				#if choose pattern 1, jump to label : hourglass
        beq	$s0, $t0, hourglass
        li	$t0, 2				#if choose pattern 2, jump to label : hexagram
        beq	$s0, $t0, hexagram
        li	$v0, 4
        la	$a0, errorType
        syscall
        li      $v0, 10
        syscall
        
        
hourglass:

	li	$t0, 0
	add	$t2, $s1, $zero
	li	$t3, 2
	mul	$t2, $t2, $t3
	L1_1:
		jal printStar
	addi	$t0, $t0, 1
	bne	$t0, $t2, L1_1
	jal nextLine
	
	li	$t0, 0
	add	$t2, $s1, $zero
	subi $t2, $t2, 1
	
	L1_2:
		li	$t1, 0
		add	$t5, $t0 ,$zero
		addi $t5, $t5, 1
		L1_2_1:
			jal	printSpace
		addi $t1, $t1, 1
		bne	$t1, $t5, L1_2_1
		
		jal	printStar
		
		li	$t4, 0
		add	$t5, $s1, $zero
		li	$t3, 2
		mul	$t5, $t5, $t3
		add	$t6, $t0, $zero
		mul	$t6, $t6, $t3
		sub	$t5, $t5, $t6
		subi	$t5, $t5, 4
		L1_2_2:
			bge	$t4, $t5, L1_2_3
			jal printSpace
		addi	$t4, $t4, 1
		jal L1_2_2
		
		L1_2_3:
			jal printStar
			jal nextLine
	addi	$t0, $t0, 1
	bne	$t0, $t2, L1_2
	
	add	$t0, $s1, $zero
	subi	$t0, $t0, 1
	L1_3:
		add	$t1, $t0, $zero
		L1_3_1:
			jal printSpace
		subi	$t1, $t1, 1
		bne	$t1, $zero, L1_3_1
		
		jal printStar
		
		add	$t4, $s1, $zero
		li	$t3, 2
		mul	$t4, $t4, $t3
		add	$t2, $t0, $zero
		mul	$t2, $t2, $t3
		sub	$t4, $t4, $t2
		subi	$t4, $t4, 2
		L1_3_2:
			ble	$t4, $zero, L1_3_3
			jal printSpace
		subi	$t4, $t4, 1
		jal L1_3_2
		
		L1_3_3:
			jal	printStar
			jal	nextLine
	subi	$t0, $t0, 1
	bne	$t0, $zero, L1_3
	
	li	$t0, 0
	add	$t2,	$s1, $zero
	li	$t3, 2
	mul	$t2, $t2, $t3
	L1_4:
		jal printStar
	addi	$t0, $t0, 1
	bne	$t0, $t2, L1_4
	
	jal nextLine
	
	li      $v0, 10
        syscall

hexagram:

        li	$t0, 0				#$t0=i
        L2_1:					#for(int i=0;i<n;i++) part1
                li	$t1, 0			#$t1=j
                add $t2, $s1, $zero		#$t2=3*n-i
        	li	$t3, 3			#$t3 use to restore constant
        	mul $t2, $t2, $t3
        	sub $t2, $t2, $t0		#set $t2 to 3*n-i
        	L2_1_1:				#for(int j=0;j<3*n-i;j++)
        		jal	printSpace
        	addi $t1, $t1, 1
        	bne $t1, $t2, L2_1_1
        	
        	li	$t4, 0			#$t4=k
        	add	$t5, $t0, $zero		#$t5=2*i+1
        	li	$t3, 2
        	mul	$t5, $t5, $t3
        	addi	$t5, $t5, 1		#set $t5 to 2*i+1
        	li	$t7, 0
        	L2_1_2:				#for(int k=0;k<2*i+1;k++)
        		beq	$t7, $zero, L2_1_2_1
			jal	printSpace
			li	$t7, 0
			jal	L2_1_2_2
			L2_1_2_1:
				jal	printStar
				li	$t7, 1
			L2_1_2_2:
        	addi	$t4, $t4, 1
        	bne	$t4, $t5, L2_1_2
        jal	nextLine
	addi	$t0, $t0, 1
	bne $t0, $s1, L2_1
	
	li	$t0, 0
	add	$t6, $s1, $zero		#$t6=n+1
	addi	$t6, $t6, 1
	L2_2:					#for(int i=0;i<n+1;i++) part2
		li	$t1, 0
		L2_2_1:				#for(int j=0;j<i;j++)
			bge	$t1, $t0, L2_2_2s
			jal	printSpace
		addi	$t1, $t1, 1
		jal	L2_2_1
		
		L2_2_2s:				#for(int k=0;k<6*n+1-2*i;k++)
		li	$t4, 0
		add	$t2, $s1, $zero	#$t2=6*n+1-2*i
		li	$t3, 6
		mul	$t2, $t2, $t3
		addi	$t2, $t2, 1
		add	$t5, $t0, $zero
		li	$t3, 2
		mul	$t5, $t5, $t3
		sub	$t2, $t2, $t5
		
		li	$t7, 0
		L2_2_2:
			beq	$t7, $zero, L2_2_2_1
			jal	printSpace
			li	$t7, 0
			jal	L2_2_2_2
			L2_2_2_1:
				jal	printStar
				li	$t7, 1
			L2_2_2_2:
		addi	$t4, $t4, 1
		bne	$t2, $t4, L2_2_2
	jal	nextLine
	addi	$t0, $t0, 1
	bne	$t0, $t6, L2_2

	add	$t0,	$s1, $zero
	L2_3:					#for(int i=n;i>0;i--) part3
		li	$t1, 0			#$t1=j=0
		add	$t2, $t0, $zero
		subi	$t2, $t2, 1		#$t2=i-1
		L2_3_1:				#for(int j=0;j<i-1;j++)
			bge	$t1, $t2, L2_3_2s
			jal printSpace
		addi	$t1, $t1, 1
		jal	L2_3_1
		
		L2_3_2s:				#for(int k=0;k<6*n+3-2*i;k++)
		li	$t4, 0			#$t4=k=0
		add	$t2, $s1, $zero	#$t2=6*n+3-2*i
		li	$t3, 6
		mul	$t2, $t2, $t3
		addi	$t2, $t2, 3
		add	$t5, $t0, $zero
		li	$t3, 2
		mul	$t5, $t5, $t3
		sub	$t2, $t2, $t5
		
		li	$t7, 0
		L2_3_2:
			beq	$t7, $zero, L2_3_2_1
			jal	printSpace
			li	$t7, 0
			jal	L2_3_2_2
			L2_3_2_1:
				jal	printStar
				li	$t7, 1
			L2_3_2_2:
		addi	$t4, $t4, 1
		bne	$t2, $t4, L2_3_2
	jal nextLine
	subi	$t0, $t0, 1
	bne	$t0,	$zero, L2_3
	
	add	$t0,	$s1, $zero
	L2_4:					#for(int i=n;i>0;i--) part4
		li	$t1, 0			#$t1=j=0
		add	$t2, $s1, $zero	#$t2=3*n-i+1
		li	$t3, 3
		mul	$t2, $t2, $t3
		addi	$t2, $t2, 1
		sub	$t2, $t2, $t0
		L2_4_1:				#for(int j=0;j<3*n-i+1;j++)
			jal printSpace
		addi	$t1, $t1, 1
		bne	$t1, $t2, L2_4_1
		
		li	$t4, 0			#$t4=k=0
		add	$t2, $t0, $zero		#$t2=2*i-1
		li	$t3, 2
		mul	$t2, $t2, $t3
		subi	$t2, $t2, 1
		li	$t7, 0
		L2_4_2:				#for(int k=0;k<2*i-1;k++)
			beq	$t7, $zero, L2_4_2_1
			jal	printSpace
			li	$t7, 0
			jal	L2_4_2_2
			L2_4_2_1:
				jal	printStar
				li	$t7, 1
			L2_4_2_2:
		addi $t4, $t4, 1
		bne	$t4, $t2, L2_4_2
	jal nextLine
	subi	$t0, $t0, 1
	bne	$t0,	$zero, L2_4
	
         li      $v0, 10
        syscall
        
printSpace:
	li	$v0, 4
	la	$a0, space
	syscall
	jr	$ra
printStar:
        li	$v0, 4
	la	$a0, star
	syscall
	jr	$ra
nextLine:
	li	$v0, 4
	la	$a0, newLine
	syscall
	jr	$ra
	.data
		pattern: .asciiz "Choose pattern : 1 for hourglass, 2 for hexagram\n>"
		size: .asciiz "Input your size n which 1<n<10\n>"
		errorType: .asciiz "type choose error"
		space: .asciiz " "
		star: .asciiz "*"
		newLine: .asciiz "\n"
