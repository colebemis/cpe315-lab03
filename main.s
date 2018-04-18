.arch armv6
.fpu vfp
.text
.global main

main:
  str lr, [sp, #-4]! /* store lr on stack */
  sub sp, sp, #8 /* make space for number 1 */

  /* print "Enter Number 1: " */
  ldr r0, printdata
  bl  printf

  /* read number 1 */
  ldr r0, printdata+12
  mov r1, sp
  bl scanf

  /* print "Enter Number 2: " */
  ldr r0, printdata+4
  bl  printf

  /* read number 2 */
  ldr r0, printdata+12
  add r1, sp, #4
  bl scanf

  /* print number 1 */
  ldr r0, printdata+20
  ldr r1, [sp]
  bl printf

  /* print number 2 */
  ldr r0, printdata+20
  ldr r1, [sp, #4]
  bl printf

  /* add operation */
  ldr r0, [sp]
  ldr r1, [sp, #4]
  bl intadd
  mov r1, r0
  ldr r0, printdata+20
  bl printf

  /* subtact operation */
  ldr r0, [sp]
  ldr r1, [sp, #4]
  bl intsub
  mov r1, r0
  ldr r0, printdata+20
  bl printf
  
  mov r0, #0 /* set return value to 0 */
  add sp, sp, #8 /* restore stack */
  ldr pc, [sp], #4 /* load pc with lr */
end:

printdata:
  .word string0
  .word string1
  .word string2
  .word string3
  .word string4
  .word string5
  .word string6
  .word string7

string0:
  .asciz "Enter Number 1: "
string1:
  .asciz "Enter Number 2: "
string2:
  .asciz "Enter Operation: "
string3:
  .asciz "%d"
string4:
  .asciz "%c"
string5:
  .asciz "Result is: %d\n"
string6:
  .asciz "Again? "
string7:
  .asciz "Invalid Operation Entered.\n"
