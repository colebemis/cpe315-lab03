.arch armv6
.fpu vfp
.text
.global main

main:
  /* store lr on stack */
  str lr, [sp, #-4]!

  /* make space for inputs */
  sub sp, sp, #16

loop:
  /* print prompt for number 1 */
  ldr r0, =prompt1
  bl  printf

  /* read number 1 */
  ldr r0, =readint
  mov r1, sp
  bl scanf

  /* print prompt for number 2 */
  ldr r0, =prompt2
  bl  printf

  /* read number 2 */
  ldr r0, =readint 
  add r1, sp, #4
  bl scanf

  /* print prompt for operation */
  ldr r0, =prompt3
  bl printf 

  /* read operation */
  ldr r0, =readchar
  add r1, sp, #8
  bl scanf
  ldrb r2, [sp, #8]

  /* load function arguments */
  ldr r0, [sp]
  ldr r1, [sp, #4]

  /* load '+' into r3 */
  ldr r3, =plus
  ldrb r3, [r3]

  /* handle addition operation */
  cmp r2, r3
  bleq intadd
  beq printresult

  /* load '-' into r3 */
  ldr r3, =minus
  ldrb r3, [r3]

  /* handle subtraction operation */ 
  cmp r2, r3
  bleq intsub
  beq printresult

  /* load '*' into r3 */
  ldr r3, =times
  ldrb r3, [r3]

  /* handle multiplication operation */
  cmp r2, r3
  bne printinvalid
  bl intmul
  b printresult
  
  /* handle invalid operation */
printinvalid:
  ldr r0, =invalid
  bl printf
  b printagain

printresult:
  /* print result */
  mov r1, r0
  ldr r0, =result
  bl printf

printagain:
  /* print again prompt */
  ldr r0, =again
  bl printf

  /* read char */
  ldr r0, =readchar
  add r1, sp, #12
  bl scanf

  /* put 'y' in r1 */
  ldr r1, =yes
  ldrb r1, [r1]

  /* put answer in r0 */
  ldrb r0, [sp, #12]

  /* compare r0 and r1 */
  cmp r0, r1
  beq loop

  /* set return value to 0 */
  mov r0, #0

  /* restore stack */
  add sp, sp, #16

  /* load pc with lr */
  ldr pc, [sp], #4
end:

prompt1:
  .asciz "Enter Number 1: "
prompt2:
  .asciz "Enter Number 2: "
prompt3:
  .asciz "Enter Operation: "
readint:
  .asciz "%d"
readchar:
  .asciz " %c"
result:
  .asciz "Result is: %d\n"
again:
  .asciz "Again? "
invalid:
  .asciz "Invalid Operation Entered.\n"
yes:
  .byte 'y'
plus:
  .byte '+'
minus:
  .byte '-'
times:
  .byte '*'
