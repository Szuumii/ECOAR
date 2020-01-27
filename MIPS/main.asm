#Program created to Read *.c files at input and remove all coments form it
#
#
 .data
inpmsg:	.asciiz "Give filename for input: "
outmsg:	.asciiz "Give filename for output: "
oupath:	.space	64
inpath:	.space	64
inpbuf:	.space 512		#Text from an input file
outbuf:	.space 512		#Text for an output file
    	
.text
fileNames:	
	
	li	$v0, 4
	la	$a0, inpmsg
	syscall
	
	li	$v0, 8
	la	$a0, inpath
	li	$a1, 64
	syscall
	
	li	$v0, 4
	la	$a0, outmsg
	syscall
	
	li	$v0, 8
	la	$a0, oupath
	li	$a1, 64
	syscall

main:
	#Open input File
	li   	$v0, 13       
  	la   	$a0, inpath     
 	li   	$a1, 0            
 	syscall            
 	move 	$s0, $v0	
	
	#Open output file
  	li   	$v0, 13       
  	la   	$a0, oupath
 	li   	$a1, 1        
 	li   	$a2, 0        
 	syscall            
 	move 	$s1, $v0

	la	$t6, inpbuf
	la	$t7, outbuf
	li	$t5, 0 #valid characters counter
	li	$t4, 0 #characters left in inpbuf counter

	
loop:
	jal	getc
	move	$t0, $v1
	beq	$t4, -1, finish
	
	beq	$t0,'"', string
	
	beq	$t0,'/', firstSlash
	
	move	$a2, $t0
	addiu	$t5, $t5, 1
	jal putc
	
	b loop
	
string:
	addiu	$t5, $t5, 1
	move	$a2, $t0
	jal	putc
	
	jal	getc
	move	$t0, $v1
	beq	$t0,'"', endOfString
	beq	$t4, -1, finish
	b string
endOfString:	
	addiu	$t5, $t5, 1
	move	$a2, $t0
	jal	putc
	b loop
	
firstSlash:
	move	$t1, $t0
	jal	getc
	move	$t0, $v1
	
	beq	$t0,'/', secondSlash
	
	beq	$t0,'*', firstAsterix

	move	$a2, $t1
	addiu	$t5, $t5, 1
	jal putc
	move	$a2 ,$t0
	addiu	$t5, $t5, 1
	jal putc

	b loop
	
secondSlash:
	jal	getc
	move	$t0, $v1
	beq	$t0,'\n', endOfLine
	beq	$t4, -1, finish
	b secondSlash
	
secondAsterix:
	jal	getc
	move	$t0, $v1
	beq	$t0,'/', loop
	
firstAsterix:
	jal	getc
	move	$t0, $v1
	beq	$t0,'*', secondAsterix
	beq	$t4, -1, finish
	b firstAsterix

endOfLine:
	move	$a2 ,$t0
	addiu	$t5, $t5, 1
	jal putc
	b loop

finish:
	li   	$v0, 15       
	move 	$a0, $s1      
  	la   	$a1, outbuf 
  	move   	$a2, $t5
  	syscall
  	  	
	#Close file
	li   	$v0, 16       
  	move 	$a0, $s0      
  	syscall
  	
  	#Close file
	li  	$v0, 16       
  	move	$a0, $s1      
  	syscall
  	
	b fileNames

#Getc function
getc:
	beq	$t4, 0, emptyBuffor

	#Read from the file
 	li   	$v0, 14      
	move 	$a0, $s0     # file descriptor 
  	la   	$a1, inpbuf  
  	li  	$a2, 512
  	syscall
  	
  	move	$t4, $v0
  	la	$t6, inpbuf
emptyBuffor:
  	lb	$v1, ($t6)
	addiu	$t6, $t6, 1
	subiu	$t4, $t4, 1	
  	jr	$ra

  	
#Putc function and additional procedures
putc:      
	sb	$a2, ($t7)
	addiu	$t7, $t7, 1
	
	bne	$t5,512, returnPutc
	
	#Write to file
	li   	$v0, 15       
	move 	$a0, $s1      
  	la   	$a1, outbuf 
  	move   	$a2, $t5
  	syscall
  	
 	subiu	$t5,$t5, 512

  	la	$t7, outbuf
returnPutc:
	jr	$ra
