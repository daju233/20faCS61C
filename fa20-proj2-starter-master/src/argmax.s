.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax:
    li t3 1
    blt a1 t3 error_call
    # Prologue
    lw t1, 0(a0) 
    mv t4 a1
    mv t5 x0
    
loop_start:
    addi a0 ,a0,4
    addi a1,a1,-1
    lw t2 0(a0)

    ble a1, x0, loop_end
    bgt t2, t1, loop_continue
    bgt a1, x0, loop_start
loop_continue:
    sub t5 t4 a1
    mv  t1, t2 # t1 = t2
    j loop_start
loop_end:
    # Epilogue
    mv a0 t5
	ret
error_call:
    li a0 77
    ret

