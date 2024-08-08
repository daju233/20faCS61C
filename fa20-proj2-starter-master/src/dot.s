.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
    # Prologue
    ble a2 x0 err1

    ble a3 x0 err2
    ble a4 x0 err2

    slli t5 a3 2
    slli t6 a4 2
    sub a0 a0 t5
    sub a1 a1 t6
    li t4 0
loop_start:
    add a0 a0 t5
    add a1 a1 t6
    lw t1 0(a0)
    lw t2 0(a1)
    mul t3 t1 t2
    add t4 t4 t3
    addi a2 a2 -1
    bgt a2, x0, loop_start
    

loop_end:

    mv a0 t4
    # Epilogue
    ret

err1:
    li a0 75
    ret

err2:
    li a0 76
    ret