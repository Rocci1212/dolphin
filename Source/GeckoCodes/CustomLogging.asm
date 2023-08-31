#To be inserted at 80330940
# Used at [$Beta: Custom Logging] at R4QP01.ini

  # right now this only supports 4 loops, but can do up to 8
  # the first 4 times it runs, r28 is 0-3
  # the next 4 times, r19 is 0-3 while r28 is various mem addresses
  cmplwi cr3, r28, 3
  bgt cr3, FINALLY # escape if we're looking at a mem address

  # figure out which loop i'm running
  cmpwi r28, 0
  cmpwi cr1, r28, 1
  cmpwi cr2, r28, 2

SET_THE_TABLE:
  # push and pop the stack
  stwu sp, -0x0050 (sp) #make space for 18 registers
  stmw r14, 0x8 (sp) #push r14-r31 onto the stack pointer

  mfctr r14 # backup the count register to r14
  mflr r15   # backup link register to r15
  mr r16, r3 # backup r3
  mr r17, r4 # backup r4
  mr r18, r5 # backup r5
  mr r19, r6 # backup r6
  mr r20, r7 # backup r7
  mr r21, r8 # backup r8
  mr r22, r9 # backup r9
  mr r23, r10 #backup r10
  
  lis r16, 0x8000 
  ori r16, r16, 0x9b34 # set r16 to nlPrintf
  mtctr r16 # set count register to nlPrintf
  
  lis r3, 0x8060 # set r3 to custom text
  lis r4, 0x8057
  lwz r4, 0xffffd2d0 (r4) # set r4 to the frame #

  beq LOOP_0
  beq cr1, LOOP_1
  beq cr2, LOOP_2
  beq cr3, LOOP_3

LOOP_0: # frame # and player inputs
  # set data to custom text

  lis r10, 0x8058
  ori r10, r10, 0x5e00
  lhz r5, 0xe2 (r10)      # set r5 to the face buttons: 0CZ0AB00 00000D00
  lwz r6, 0x94 (r10)      # set r6 to the stick intensity
  lwz r7, 0x140 (r10)     # set r7 to the stick X
  lwz r8, 0x144 (r10)     # set r8 to the stick Y
  lwz r9, 0xfc (r10)      # set r9 to the wiimote rumble
  lwz r10, 0x158 (r10)    # set r10 to the nunchuk rumble

  bctrl # branch and link to nlPrint
  b CLEAN_UP

LOOP_1: #Ball XYZ values
  # set data to custom text
  ori r3, r3, 0x20

  li r4, 0
  ori r4, r4, 0xba11

  lis r10, 0x806d
  ori r10, r10, 0xf7a0    # 806df7a0 is a pointer to the ball object
  lwz r10, 0 (r10)        # load the object itself
  lwz r5, 0x218 (r10)     # loose ball X location
  lwz r6, 0x21c (r10)     # loose ball Y location
  lwz r7, 0x220 (r10)     # loose ball Z location
  lwz r8, 0x268 (r10)     # loose ball X velocity
  lwz r9, 0x26c (r10)     # loose ball Y velocity
  lwz r10, 0x270 (r10)    # loose ball Z velocity

  bctrl # branch and link to nlPrint
  b CLEAN_UP

LOOP_2: # Random Seeds
  # set data to custom text


  #bctrl # branch and link to nlPrint
  b CLEAN_UP


LOOP_3: # Random Seeds
  # set data to custom text


  #bctrl # branch and link to nlPrint
  b CLEAN_UP

CLEAN_UP:
  mr r3, r16 # restore r3
  mr r4, r17 # restore r4
  mr r5, r18 # restore r5
  mr r6, r19 # restore r6
  mr r7, r20 # restore r7
  mr r8, r21 # restore r8
  mr r9, r22 # restore r9
  mr r10, r23 #restore r10
  mtctr r14  # restore count register
  mtlr r15   # restore link register

  lmw r14, 0x8 (sp) #pop r14-r31 off the stack pointer
  addi sp, sp, 0x0050 #release the space  

FINALLY:
  sth	r0, 0x0088 (r3) # original instruction at 80330940
