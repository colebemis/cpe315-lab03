.global intmul

/*
 * r2: multiplicand
 * r3: multiplier
 * r4: result
 * r5: counter
 * r6: temp
 */

intmul:
  /* save registers on stack */
  push {r2, r3, r4, r5, r6, lr}

  /* save multiplicand in r3 */
  mov r2, r0

  /* save multiplier in r4 */
  mov r3, r1

  /* intialize result to 0 */
  mov r4, #0

  /* intialize counter to 32 */
  mov r5, #32

loop:
  /* check if multiplier has a 1 in least significant bit */
  and r6, r3, #1
  cmp r6, #0
  beq update

  /* add r2 and r4 and store result in r4 */
  mov r0, r2
  mov r1, r4
  bl intadd
  mov r4, r0

update:
  /* shift multiplicand to the left (x2) */
  mov r2, r2, asl #1

  /* shift multiplier to the right (/2) */
  mov r3, r3, asr #1

  /* decrement counter */
  sub r5, r5, #1

  /* check if counter is zero */
  cmp r5, #0
  bne loop

return:
  /* set return value */
  mov r0, r4

  /* restore registers and return */
  pop {r2, r3, r4, r5, r6, pc}
