.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    mv x5 a0
    li x6 1
        loop:
        addi a0,a0,-1
        mul x5 x5 a0
        bne a0 x6 loop
   mv a0 x5
   jr ra
