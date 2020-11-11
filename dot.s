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
    # BEGIN PROLOGUE
    addi sp, sp, -44
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
    # END PROLOGUE
    mv s0, a0 # Copy start of vector v0 to saved register
    mv s1, a1 # Copy start of vector v1 to saved register 
    mv s2, a2 # Copy the length of the vectors to saved register
    li t0, 1
    blt s2, t0, exitt1
    mv s3, a3 # Copy the stride of vector v0
    mv s4, a4 # Copy the stride of vector v1
    blt s3, t0, exitt2
    blt s4, t0, exitt2
    li s5, 0 # initialize the dot product
    li s6, 0 # Initialize counter to 0
    li s7, 0 # Initialize counter to 0
    li s8, 0
    li s9, 0

loop_start:
	addi t1, x0, 1
	blt s2, t1, loop_end
    blt s3, t1, loop_end
    blt s4, t1, loop_end

loop_continue:
	beq s6, s2, loop_end
    beq s7, s2, loop_end
    slli t2, s6, 2 # Convert array index to byte offset
    slli t3, s7, 2 # Convert array index to byte offset
    add t4, s0, t2 # Add offset to start of vector v0
    add t5, s1, t3 # Add offset to start of vector v1

    # Prepare to call helper_fn
    # addi sp, sp, -8
    # sw t3, 0(sp) # save the counter t3
    # sw t4, 4(sp) # save the counter t4
    # jal helper_fn
   	# lw t3, 0(sp) # restore t0 
    # lw t4, 4(sp)
    # addi sp, sp, 8 # clear stack
    # Finished call for helper_fn

    lw s8, 0(t4)
    lw s9, 0(t5)
    mul t6, s8, s9
    add s5, s5, t6
    
    add t2, x0, x0
    add t3, x0, x0
    add t4, x0, x0
    add t5, x0, x0
    add t6, x0, x0
    add s8, x0, x0
    add s9, x0, x0

    add s6, s6, s3 # Increment t3 counter
    add s7, s7, s4 # increment t4 counter 
    j loop_continue

loop_end:
    add a0, s5, x0
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
    addi sp, sp, 44
    # END EPILOGUE    
    ret

# helper_fn:
#     # BEGIN PROLOGUE
#     addi sp, sp, -4 
#     sw s0, 0(sp)
#     # END PROLOGUE
#     lw t1, 0(a0)
#     lw t2, 0(a1)
# 	mul s0, t1, t2
#     add s5, s5, s0
#     sw s0, 0(a0)
#     # BEGIN EPILOGUE
#     lw s0, 0(sp)
#    	addi sp, sp, 4
#     # END EPILOGUE
#     ret
    
exitt1:
    li a1 75
    jal exit2
exitt2:
    li a1 76
    jal exit2