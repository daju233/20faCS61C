.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
# Exceptions:
# - If you receive an fopen error or eof,
#   this function terminates the program with error code 93.
# - If you receive an fwrite error or eof,
#   this function terminates the program with error code 94.
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 95.
# ==============================================================================
write_matrix:

    # Prologue
    addi sp sp -24
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)


    mv s0 a0 #filename
    mv s1 a1 #start of matrix
    mv s2 a2 #rows in the matrix
    mv s3 a3 #columns of matrix

    mv a1 s0
    li a2 1
    jal fopen
    li t0 -1
    beq a0 t0 exit_93
    mv s4 a0 #fd

    #allocate buffer 
    li a0 8
    jal malloc
    #beq x0 a0 exit_88

    #store the data to buffer
    sw s2 0(a0)
    sw s3 4(a0)

    #write rows and cols
    mv a1 s4
    mv a2 a0
    li a3 2
    li a4 4
    jal fwrite
    li t0 2
    bne a0 t0 exit_94


    #write matrix
    mv a1 s4
    mv a2 s1
    mul a3 s2 s3
    li a4 4
    jal fwrite
    mul t0 s2 s3
    bne a0 t0 exit_94

    mv a1 s4
    jal fclose
    li t0 -1
    beq t0 a0 exit_95

    lw s4 20(sp)
    lw s3 16(sp)
    lw s2 12(sp)
    lw s1 8(sp)
    lw s0 4(sp)
    lw ra 0(sp)

    addi sp sp 24
    ret

# exit_88:

#     li a1 88
#     jal exit2


exit_93:

    li a1 93
    jal exit2

exit_94:

    li a1 94
    jal exit2

exit_95:

    li a1 95
    jal exit2

    # Epilogue


