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
    # BEGIN PROLOGUE
	addi sp, sp, -48
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw ra, 24(sp)
    sw s6, 28(sp)
    sw s7, 32(sp)
    sw s8, 36(sp)
    sw s9, 40(sp)
    sw s10, 44(sp)
    # END PROLOGUE

    mv s0, a0 # Copy mo to saved register
    mv s1, a1 # row of m0
    mv s2, a2 # column of m0
    mv s3, a3 # Copy m1 to saved register 
    mv s4, a4 # row of m1
    mv s5, a5 # column of m1
    mv s6, a6 # start of d
    li s7, 0 # Initialize m0 outer row counter to 0
    li s8, 0 # Initialize m1 inner column counter to 0
    li s10, 0 # Initialize return array d counter to 0

    # ERROR CHECKS
    addi t2, x0, 1
    #check rows and columns of m0, m1
    blt s1, t2, exitt1 #exit with code 72
    blt s2, t2, exitt1 #exit with code 72
    blt s4, t2, exitt2 #exit with code 73
    blt s5, t2, exitt2 #exit with code 73
    # check if dimensions of m0 and m1 match. 
    bne s2, s4, exitt3 #exit with code 74

outer_loop_start:
    #OUTER LOOP: for rows of m0
    beq s7, s1, outer_loop_end # s1 = rows of m0 
    mul t3, s2, s7 # t3 = counter * numCols of m0
    slli t4, t3, 2 # Convert array index to byte offset
    add a0, s0, t4 # Add offset to start of m0. Offset = # numcols * counter * 4
    mv s9, a0

inner_loop_start:
    
    #INNER LOOP: for columns of m1
    beq s8, s5, inner_loop_end # s5 = columns of m1
    slli t5, s8, 2 # Convert array index to byte offset
    add a0, s9, x0 # add
    add a1, s3, t5 # Add offset to start of m1
    add a2, s2, x0 # a2 = s2 = s4. The length is column of m0 or row of m1.
    addi a3, x0, 1 # the stride of m0
    add a4, x0, s5 # the stride of m1

    # CALLING DOT, PASSING IN a0, a1, a2, a3, a4
    jal ra dot

    # THE RETURNED a0 now contains the dot product.
    add t5, a0, x0 # store the return value from a0 to t5
    slli t3, s10, 2 # get the byteoffset. S10 is the counter for the d array
    add t6, s6, t3 # add off set to s6, the beginning of d array to get the location, store in t6.
    sw t5, 0(t6) # store value into that address
    addi s10, s10, 1 # increment the counter for d array

    # INCREMENT COLUMN 
    addi s8, s8, 1
    j inner_loop_start

inner_loop_end:

    # INCREMENT ROW
    addi s7, s7, 1
    j outer_loop_start

outer_loop_end:
    add a0, s6, x0
    # BEGIN EPILOGUE
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw ra, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    lw s9, 40(sp)
    lw s10, 44(sp)
    addi sp, sp, 48
    # END EPILOGUE    
    ret


exitt1:
    li a1 72
    jal exit2
exitt2:
    li a1 73
    jal exit2
exitt3:
    li a1 74
    jal exit2
