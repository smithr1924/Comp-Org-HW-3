##############
# Ryan Smith & Nicolaas Verbeek #
# Section 4 #
##############

				.data
get_int:		.asciiz "Please input an integer: "
num0s:			.asciiz "Number of 0s in the right half = "
num1s:			.asciiz "Number of 1s in the left half = "
pow4:			.asciiz "Biggest power of 4 = "
smallest:		.asciiz "Smallest decimal digit = "
newline:		.asciiz "\n"

				.text
				.globl main

main:
	li $v0, 4 # Prepare to print a string
	la $a0, get_int # Load the string
	syscall # Ask the user for an integer
	li $v0, 5 # Prepare to read in an integer
	syscall  # Get the integer from the user
	move $t4, $v0 #$t4 now stores the integer input by the user
	jal printnewline

	jal calcleft
	li $v0, 4
	la $a0, num1s #Load string to print
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	jal printnewline

	jal calcright
	li $v0, 4
	la $a0, num0s #Load string to print
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	jal printnewline
#
#	jal calc4power
#	li $v0, 4
#	la $a0, pow4 #Load string to print
#	syscall
#	jal print_newline
#
#	jal calcsmallest
#	li $v0, 4
#	la $a0, smallest #Load string to print
#	syscall
#	jal printnewline

	jal end

calcleft:
	li $t1, 0 # Counter for 1s in left half
	and $s4, $t4, 0xFF00 # Store the left half of the integer in $s0, with 16 extra 0 bits to the right
	move $s1, $ra #Store the return point in $s1
	j loop

loop:
	beq $s4, 0, endloop
	addi $t1, $t1, 1
	addi $s2, $s4, -1
	and $s4, $s4, $s2
	j loop

endloop:
	move $ra, $s1 #Prepare to return to main 
	jr $ra # Return to the main function

calcright:
	li $t1, 0 # Counter for 0s in right half
	and $s4, $t4, 0x00FF
	xor $s4, $s4, 0x00FF # Store the right half of the integer in $s0, with 16 extre 0 bits to the left
	move $s1, $ra
	j loop

calc4power:

	jr $ra

calcsmallest:

	jr $ra

printnewline: # Prints a new line, then returns to where we were
	li $v0, 4
	la $a0, newline
	syscall
	jr $ra

end:
	li $v0, 10
	syscall