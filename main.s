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

  /* add operation */
  ldr r0, [sp]
  ldr r1, [sp, #4]
  bl intadd
  mov r1, r0
  ldr r0, =result
  bl printf

  /* subtact operation */
  /* commenting this one out for now
  ldr r0, [sp]
  ldr r1, [sp, #4]
  bl intsub
  mov r1, r0
  ldr r0, =result
  bl printf
  */

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
