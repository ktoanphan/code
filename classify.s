.globl classify

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    # Exceptions:
    # - If there are an incorrect number of command line args,
    #   this function terminates the program with exit code 89.
    # - If malloc fails, this function terminats the program with exit code 88.
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>


    # BEGIN PROLOGUE
    addi sp, sp -52
    sw s0, 4(sp)            # cols of input
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)           # pointer to m0
    sw s4, 20(sp)           # pointer to m1
    sw s5, 24(sp)           # pointer to input
    sw s6, 28(sp)           # pointer to what matmul returns
    sw s7, 32(sp)           # rows of m0 
    sw s8, 36(sp)           # cols of m0
    sw s9, 40(sp)           # rows of m1
    sw s10, 44(sp)          # cols of m1
    sw s11, 48(sp)          # rows of input
    # END PROLOGUE

    mv s1, a1               # save a1
    mv s2, a2               # save a2

    # EXCEPTIONS
    li t0, 5                # 5 arguments, including name of the program main.s
    bne a0, t0, exitt0      # exit with code 89

	# =====================================
    # LOAD MATRICES
    # =====================================

    # Allocating memory for two integer pointers (row and column)
    li a0, 4
    jal malloc 
    beq a0, x0, exitt1	# if malloc returns an error, error with code 88
    mv s7, a0 
    li a0, 4
    jal malloc 
    beq a0, x0, exitt1	# if malloc returns an error, error with code 88
    mv s8, a0   
        
    li a0, 4
    jal malloc 
    beq a0, x0, exitt1	# if malloc returns an error, error with code 88
    mv s9, a0  
    li a0, 4
    jal malloc 
    beq a0, x0, exitt1	# if malloc returns an error, error with code 88
    mv s10, a0      
    mul a0, s9, s1
    
    li a0, 4
    jal malloc 
    beq a0, x0, exitt1	# if malloc returns an error, error with code 88
    mv s11, a0 
    li a0, 4
    jal malloc 
    beq a0, x0, exitt1	# if malloc returns an error, error with code 88
    mv s0, a0

    # Load pretrained m0
    lw a0, 4(s1)            # a0 = M0_PATH
    add a1, s7, x0          
    add a2, s8, x0
    jal read_matrix
    mv s3, a0               # s3 = pointer to matrix m0

    # Load pretrained m1
    lw a0, 8(s1)            # a0 = M1_PATH
    add a1, s9, x0          
    add a2, s10, x0
    jal read_matrix
    mv s4, a0               # s4 = pointer to matrix m1

    # Load input matrix
    lw a0, 12(s1)            # a0 = INPUT_PATH
    add a1, s11, x0          
    add a2, s0, x0
    jal read_matrix
    mv s5, a0               # s5 = pointer to matrix input

    # free pre allocated memory 
    # mv a0, s7
    # jal free
    # mv a0, s8 
    # jal free
    # mv a0, s9 
    # jal free
    # mv a0, s10
    # jal free
    # mv a0, s11
    # jal free
    # mv a0, s0
    # jal free

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input = hidden_layer

    mul a0, s7, s0
    slli a0, a0, 2
    jal malloc 
    mv s6, a0
    lw a1, 0(s7)
    lw a2, 0(s8)
    lw a4, 0(s11)
    lw a5, 0(s0)
    add a0, s3, x0          # a0 = s3 which is pointer to m0
    add a3, s5, x0          # a3 = s5 which is pointer to input
    add a6, s6, x0          # s6 now pointers to the output of matmul
    jal matmul      
    # mv s6, a0    

    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    add a0, s6, x0          # s6 is pointer to (m0 * input)
    mul a1, s7, s0          # a1 = s7 * s0 = rows of m0 * columns of input
    jal relu

    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)

    # mul a0, s9, s0
    # jal malloc
    # mv s1, a0

    # lw a1, 0(s9)
    # lw a2, 0(s10)
    # lw a4, 0(s7)            # a4 = rows of m0
    # lw a5, 0(s0)            # a5 = columns of input
    # add a0, s4, x0          # a0 = s4 pointer to m1
    # add a3, s6, x0          # a3 = ReLU(m0 * input)
    # add a6, s1, x0          # s6 is matmul(m1, hidden_layer)
    # jal matmul

    # mv a0, s0
    # jal free


    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    # lw a0, 16(s1)
    # add a1, s6, x0          # pointer to start of matrix
    # add a2, s9, x0          # a2 = s9 = rows of m1
    # add a3, s0, x0          # a3 = s0 = columns of input
    # jal write_matrix


    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    # add a0, s6, x0
    # mul a1, s9, s0          
    # jal argmax
    # add s6, a0, x0          # s6 = a single integer representing the classification

    # li t0, 0
    # bne s2, t0, Next

    # # Print classification
    # add a1, s6, x0          # a1 = s6 = classification integer to print. 
    # jal print_int


    #  Print newline afterwards for clarity
    li a1 '\n'
    jal print_char


Next:
    # add a0, x0, x0
    # BEGIN EPILOGUE
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)           # pointer to m0
    lw s4, 20(sp)           # pointer to m1
    lw s5, 24(sp)           # pointer to input
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    lw s9, 40(sp)
    lw s10, 44(sp)
    lw s11, 48(sp)
    addi sp, sp 52
    # END EPILOGUE
    ret

exitt0: 
    li a1 89 # incorrect argc
    jal exit2

exitt1:
    li a1 88 # failed malloc
    jal exit2
