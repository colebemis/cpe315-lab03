	.global intsub
intsub:
   push {r6, lr}	/* place local variable (carry) on stack */
   mov r4, r0		/* save operand 1 */
   mov r5, r1		/* save operand 2 */
while:
   cmp r5, #0 		/* while y does not equal zero */
   beq exit		/* if operand 2 equals zero, exit */
   mvn r6, r4		/* negate operand 1 */
   and r6, r6, r5	/* AND ~x with y to get carry bits */
   eor r4, r4, r5	/* subtract x and y where at least one of the bits is not set */
   mov r5, r6, lsl #1   /* operand 2 updated to carry left shift by 1 */
   b while 		/* unconditional branch to while statement */
exit:
   mov r0, r4		/* copy result in r4 to return register */
   pop {r6, pc}		/* deallocate stack */

