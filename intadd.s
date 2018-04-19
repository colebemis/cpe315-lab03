	.global intadd
intadd:
   push {r4, r5, r6, lr}      	/* push callee local variables(carry variable) onto stack */
   mov r4, r0 	      	/* save a copy of operand 1 to r4 */
   mov r5, r1         	/* save a copy of operand 2 to r5 */
while:
   cmp r5, #0	      	/* check if operand 2 is 0 */
   beq exit		/* conditional branch if operand 2 is zero */
   and r6, r4, r5     	/* bitwise AND to get all carry bits */
   eor r4, r4, r5     	/* sum of bits where at least one of the bits is not set*/
   mov r5, r6, lsl #1 	/* shift the carry by 1 and copy to operand 2 */
   b while		/* unconditional branch to while statement */
exit:
   mov r0, r4		/* copy result into return register */
   pop {r4, r5, r6, pc}		/* deallocate stack */
   
