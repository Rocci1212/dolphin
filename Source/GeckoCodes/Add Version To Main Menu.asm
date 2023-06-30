#To be inserted at 803014AC
  # PUSH r14-r31 INTO THE STACK (not 100% sure this is safe)
  stwu sp, -0x0050 (sp)  # make space for 18 registers
  stmw r14, 0x8 (sp)     # push r14-r31 onto the stack pointer

  mr r14, r0
  addi r14, r14, 0x4CEA  
  addi r14, r14, 0x4000  # add 8cea to get us to the right spot in memory

  lis r23, 0x53          # S
  ori r23, r23, 0x50     # P
  lis r24, 0x4F          # O
  ori r24, r24, 0x4F     # O
  lis r25, 0x4B          # K
  ori r25, r25, 0x59     # Y
  lis r26, 0x20          # Space
  ori r26, r26, 0x4D     # M
  lis r27, 0x53          # S
  ori r27, r27, 0x43     # C
  lis r28, 0x20          # Space
  ori r28, r28, 0x76     # v
  lis r29, 0x30          # 0
  ori r29, r29, 0x2e     # .
  lis r30, 0x34          # 4
  ori r30, r30, 0x2e     # .
  lis r31, 0x30          # 0

  stmw r23, 0 (r14)
    
  lmw r14, 0x8 (sp)      # pop r14-r31 off the stack pointer
  addi sp, sp, 0x0050    # release the space
  lwz r0, 20 (r1)        # original instruction at 803014AC


