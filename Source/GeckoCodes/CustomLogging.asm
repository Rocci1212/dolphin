#To be inserted at 80330940
  # push and pop the stack

  cmpwi r28, 0
  bne FINALLY

  stwu sp, -0x0050 (sp) #make space for 18 registers
  stmw r14, 0x8 (sp) #push r14-r31 onto the stack pointer

  mfctr r14 # backup the count register to r14

  lis r15, 0x8000 
  ori r15, r15, 0x9b34 # set r15 to nlPrintf
  mtctr r15 # set link register to nlPrintf

  # set data to custom text
  mr r15, r3 # backup r3
  mr r16, r4 # backup r4
  mflr r17   # backup link register
  lis r3, 0x8060 #set r3 to custom text
  lis r4, 0x80c2
  lwz r4, 0x4180 (r4) # set r4 to the frame #

  bctrl # branch and link to nlPrint feels weird to do this with more to go after

CLEAN_UP:
  mr r3, r15 # restore r3
  mr r4, r16 # restore r4
  mtctr r14  # restore count register
  mtlr r17   # restore link register

  lmw r14, 0x8 (sp) #pop r14-r31 off the stack pointer
  addi sp, sp, 0x0050 #release the space  

FINALLY:
  sth	r0, 0x0088 (r3) # original instruction at 80330940

