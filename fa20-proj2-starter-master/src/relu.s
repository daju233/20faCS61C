.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    # Prologue
    li t2 1
    blt a1 t2 error_call
    addi a0,a0,-4
loop_start:
    addi a0,a0,4
    addi a1,a1,-1
    
    lw t0 0(a0)

    ble a1, x0, loop_end
    bge t0, x0, loop_start
    blt t0, x0, loop_continue
loop_continue:
    sw x0 0(a0)
    j loop_start
loop_end:
    # Epilogue
	ret
error_call:
    li a0 78
    ret


