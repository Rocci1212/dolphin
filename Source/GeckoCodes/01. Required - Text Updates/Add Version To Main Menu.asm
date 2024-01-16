#To be inserted at 803014AC
# Used at [$Required: Text Updates] at R4QP01.ini
  # PUSH r14-r31 INTO THE STACK (not 100% sure this is safe)
  stwu sp, -0x0050 (sp)  # make space for 18 registers
  stmw r14, 0x8 (sp)     # push r14-r31 onto the stack pointer

  mr r14, r0
  addi r14, r14, 0x4000
  addi r14, r14, 0x4000  # add 8000 to get us to the right spot in memory
  mr r15, r14            # save register to be further manipulated

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
  lis r31, 0x37          # 7

  stmw r23, 0xcea (r14)

  addi r15, r15, 0x6000  
  addi r15, r15, 0x6000  
  addi r15, r15, 0x4000  # add 18000 to r0 to get us to the right spot in memory
  mr r16, r15            # save register to be further manipulated
  
  lis r26, 0x43          # C
  ori r26, r26, 0x53     # S
  lis r27, 0x4c          # L
  ori r27, r27, 0x20     # Space
  lis r28, 0x53          # S
  ori r28, r28, 0x54     # T
  lis r29, 0x41          # A
  ori r29, r29, 0x44     # D
  lis r30, 0x49          # I
  ori r30, r30, 0x41     # A
  lis r31, 0             # Terminator

  stmw r26, 0x442 (r15)
  
  addi r16, r16, 0x6000  
  addi r16, r16, 0x6000  
  addi r16, r16, 0x4000  # add 28000 to r0 to get us to the right spot in memory
  
  lis r21, 0x4f          # O
  ori r21, r21, 0x52     # R
  lis r22, 0x49          # I
  ori r22, r22, 0x47     # G
  lis r23, 0x49          # I
  ori r23, r23, 0x4e     # N
  lis r24, 0x41          # A
  ori r24, r24, 0x4C     # L
  lis r25, 0x20          # Space
  ori r25, r25, 0x46     # F
  lis r26, 0x49          # I
  ori r26, r26, 0x45     # E
  lis r27, 0x4C          # L
  ori r27, r27, 0x44     # D
  lis r28, 0x20          # Space
  ori r28, r28, 0x53     # S
  lis r29, 0x50          # P
  ori r29, r29, 0x45     # E
  lis r30, 0x45          # E
  ori r30, r30, 0x44     # D
  lis r31, 0x53          # S

  stmw r21, 0xeca (r16)

  lmw r14, 0x8 (sp)      # pop r14-r31 off the stack pointer
  addi sp, sp, 0x0050    # release the space
  lwz r0, 20 (r1)        # original instruction at 803014AC


