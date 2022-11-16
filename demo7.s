# Nicholas Almeida
# 200385

.data
integer_prompt: .asciiz "Hello, please tell me the number of characters in your name: "
name_prompt: .asciiz "Please enter your name: "
response: .asciiz "Hello "
nl: .asciiz "\n"

.text
main:
	# prompt the user for an integer
	li $v0, 4
	la $a0, integer_prompt
	syscall

	# read the integer
	li $v0, 5
	syscall

	# store the integer in $t0
	addi $t0, $v0, 2 # add 2. One for the newline, one for the null terminator

	# allocate an appropriate amount of memory dynamically to store the name using the integer
	li $v0, 9
	move $a0, $t0
	syscall

	# store the address of the allocated memory in $t1
	addi $t1, $v0, 0

	# prompt the user for their name
	li $v0, 4
	la $a0, name_prompt
	syscall

	# read the name into the allocated memory
	li $v0, 8
	move $a0, $t1
	move $a1, $t0	# the maximum number of characters to read is the integer
	syscall

	# print the response
	li $v0, 4
	la $a0, response
	syscall

	# print the name
	li $v0, 4
	move $a0, $t1
	syscall

	# print a newline
	li $v0, 4
	la $a0, nl
	syscall

	# free the allocated memory
	li $v0, 10
	move $a0, $t1
	syscall

	# exit
	li $v0, 10
	syscall