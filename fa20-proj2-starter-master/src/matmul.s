.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:

    # Error checks
    

    # Prologue
    mv t0 a1
    mv t1 a5
    mv t2 a2
    addi a0 a0 -4 //heightA=a1 widthB=a5 widthA=a2
    addi a3 a3 -4
    addi a6 a6 -4
outer_loop_start:
    addi a0 a0 4
    addi a3 a3 4
    addi a6 a6 4
inner_loop_start:
    mul a1     





    
inner_loop_end:
    addi a2 a2 -1
    bnez a2 inner_loop_start 

    addi a5 a5 -1
    bnez a2 inner_loop_start 

outer_loop_end:
    addi a1 a1 -1
    bnez a1 outer_loop_start 
    # Epilogue
    
    
    ret
