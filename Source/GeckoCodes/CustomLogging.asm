#To be inserted at 80330940
# Used at [$Beta: Custom Logging] at R4QP01.ini
  # push and pop the stack

  cmpwi r28, 0
  bne FINALLY

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

  lis r24, 0x8000 
  ori r24, r24, 0x9b34 # set r24 to nlPrintf
  mtctr r24 # set count register to nlPrintf

  # set data to custom text
  lis r3, 0x8060 # set r3 to custom text
  lis r4, 0x8057
  lwz r4, 0xffffd2d0 (r4) # set r4 to the frame #

  lis r10, 0x8058
  ori r10, r10, 0x5e00
  lhz r5, 0xe2 (r10)      # set r5 to the face buttons: 0CZ0AB00 00000D00
  lwz r6, 0x94 (r10)      # set r6 to the stick intensity
  lwz r7, 0x140 (r10)     # set r7 to the stick X
  lwz r8, 0x144 (r10)     # set r8 to the stick Y
  lwz r9, 0xfc (r10)      # set r9 to the wiimote rumble
  lwz r10, 0x158 (r10)    # set r10 to the nunchuk rumble

  # Ball XYZ values, kind of scuffed
  #lis r10, 0x806d
  #ori r10, r10, 0xf7a0
  #lwz r5, 0x218 (r10)
  #lwz r6, 0x21c (r10)
  #lwz r7, 0x220 (r10)
  #lwz r8, 0x268 (r10)
  #lwz r9, 0x26c (r10)
  #lwz r10, 0x270 (r10)

  bctrl # branch and link to nlPrint

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
