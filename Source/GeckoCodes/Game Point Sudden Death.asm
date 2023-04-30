#To be inserted at 8005A6BC
# I use a technique called Pushing/Popping the stack here, as shown here:
# https://mariokartwii.com/showthread.php?tid=873
CHECK_SCORE_AND_LIMIT:
  stwu sp, -0x0050 (sp) # make space for 18 registers
  stmw r14, 0x8 (sp)    # push r14-r31 onto the stack pointer

  lis r14, 0x80C6       # Load 80c60000 into r14
  lhz r15, -3534 (r14)  # Load value at 80c5F232 (Score Limit) into r15
  lhz r16, 25786 (r14)  # Load value at 80c664BA (Score 1) into r16
  subi r15, r15, 0x1    # Subtract 1 from r15 and store it in r15
  cmpw cr2, r15, r16    # Compare with r16
  bne- cr2, FINALLY     # If not equal, it's not sudden death, branch to end
  lhz r17, 25784 (r14)  # Load value at 80c664B9 (Score 2) into r17
  cmpw cr2, r16, r17    # Compare Score 1 with Score 2
  bne- cr2, FINALLY      # Branch if not equal
  lis r15, 0x4396       # Load 43960000 into r15
  lis r14, 0x80CF       # Load 80cf0000 into r14
  stw r15, 20728(r14)   # Store 43960000 into 80cf50f8

FINALLY:
  lmw r14, 0x8 (sp)     # pop r14-r31 off the stack pointer
  addi sp, sp, 0x50     # release the space
  lfs f2, 28(r31)       # Original instruction at 8005a6bc

