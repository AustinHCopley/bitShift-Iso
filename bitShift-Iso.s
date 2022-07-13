.data
str1:
	.asciiz "Please enter a number: "
str2:
	.asciiz "Would you like to shift or isolate the number (0 or 1 respectively)? "
shift:
	.asciiz "Shift left or right (0 or 1)? "
quantity:
	.asciiz "By how many bits? "
isolate_start:
	.asciiz "Enter the starting bit to isolate: "
isolate_end:
	.asciiz "Enter the ending bit to isolate: "
result:
	.asciiz "Result: "
end_prompt:
	.asciiz "Stored. Would you like to manipulate another number (0 for no, 1 for yes)? "
history:
	.asciiz "History: "
newline:
	.asciiz "\n"

.text
main:

Continue:

addi $s7, $zero, 1			##iterate the count of runs

li $v0, 4			#system call code 4 for printing a string
la $a0, str1			#load address for string 1
syscall					##print "Please enter a number: "

li $v0, 5			#system call code 5 for reading an integer
syscall					##read user input for number
add $s0, $v0, $zero		#move user-inputted variable from $v0 to $s0

#
li $v0, 4
la $a0, newline
syscall
#

li $v0, 4
la $a0, str2
syscall					##print "Would you like to shift or isolate the number (0 or 1 respectively)? "

li $v0, 5
syscall
add $s1, $v0, $zero			##read user input for shift/isolate

#
li $v0, 4
la $a0, newline
syscall
#

bne $s1, $zero, Isolate		#branch to Isolate if $s1 is not equal to zero, continue to Shift instructions if equal to zero
#continue if Shift:

li $v0, 4
la $a0, shift				##print "Shift left or right (0 or 1)? "
syscall

li $v0, 5			#system call code 5 for reading an integer
syscall					##read user input for left or right
add $s1, $v0, $zero		#move user-inputted variable from $v0 to $s1

#
li $v0, 4
la $a0, newline
syscall
#

li $v0, 4
la $a0, quantity
syscall					##print "By how many bits? "

li $v0, 5
syscall
add $s2, $v0, $zero			##read user input for number of bits to shift

#
li $v0, 4
la $a0, newline
syscall
#

bne $s1, $zero, Right
#continue if left:

sllv $s0, $s0, $s2

j Result			#jump unconditionally to Result

Right:

srlv $s0, $s0, $s2

j Result			#jump unconditionally to Result

Isolate:

li $v0, 4
la $a0, isolate_start			##print "Enter the starting bit to isolate: "
syscall

li $v0, 5
syscall
add $s3, $v0, $zero			##read input for starting bit

#
li $v0, 4
la $a0, newline
syscall
#

li $v0, 4
la $a0, isolate_end			##print "Enter the ending bit to isolate: "
syscall

li $v0, 5
syscall
add $s4, $v0, $zero			##read input for ending bit

#
li $v0, 4
la $a0, newline
syscall
#

##perform calculation
addi $s2, $zero, 32
sub $s5, $s2, $s4
addi $s5, $s5, -1
sllv $s0, $s0, $s5
srlv $s0, $s0, $s5
srlv $s0, $s0, $s3
sllv $s0, $s0, $s3


Result:

li $v0, 4			#system call code for printing string
la $a0, result			#load address of result string
syscall

sw $s0, ($sp)			##store the result in memory

add $a0, $s0, $zero
li $v0, 1 				##print the result
syscall

#
li $v0, 4
la $a0, newline
syscall
#

li $v0, 4 				##print prompt
la $a0, end_prompt
syscall

li $v0, 5
syscall
add $s1, $v0, $zero

#
li $v0, 4
la $a0, newline
syscall
#



bne $s1, $zero, Continue 		##restart if user selects 1

li $v0, 4
la $a0, history
syscall

#
li $v0, 4
la $a0, newline
syscall
#

add $s6, $zero, $zero			##initialize iterator s6

For:

lw $t0, ($sp)				##load word from top of stack pointer

li $v0, 1
la $a0, ($t0)
syscall

#
li $v0, 4
la $a0, newline
syscall
#

addi, $s6, $s6, 1
bne $s7, $s6, For

li $v0, 10
syscall
