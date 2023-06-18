#To be inserted at 80333344
# Fix Random Seed Desyncs - Console
# Code should correct the Dolphin machine's random seed when a seed desync happens
# My Machine ID: 80c26404
# Random Seed 0: 80c41f1c
# Random Seed 1: 80c41f20

BEGINNING:
  cmplw	r3, r0             # our original instruction is a compare
  beq WEGOOD               # skip this step if our Random Seeds are in sync
  li r25, 1                # runs only if Random Seeds not in sync - store 1 in memory
  b SOME_FUNK

WEGOOD:
  li r25, 0
  b END

SOME_FUNK:
  # I use a technique called Pushing/Popping the stack here, as shown here:
  # https://mariokartwii.com/showthread.php?tid=873
  stwu sp, -0x0050 (sp) # make space for 18 registers
  stmw r14, 0x8 (sp)    # push r14-r31 onto the stack pointer

  lis r14, 0x80c2
  ori r14, r14, 0x6404  # set r14 to 80c26404
  lwz r14, 0 (r14)      # load the machine id into r14 (should be 1 or 0)
  
  lis r15, 0x80c4         
  ori r15, r15, 0x1f1c  # load 80c41f1c into r15 (we're going to use this as the address to overwrite)
  mr r16, r15           # copy r15 to r16 (this will be the location of the wii's correct random seed)

  cmpwi r14, 1
  bne MORE_FUNK
  addi r15, r15, 4
  b 0x8

MORE_FUNK:
  addi r16, r16, 4      # this should get skipped by the end of SOME_FUNK
  lwz r16, 0 (r16)      # load the wii's random seed into r16
  stw r16, 0 (r15)      # store wii's random seed into location of dolphin's random seed

  lmw r14, 0x8 (sp)     # pop r14-r31 off the stack pointer
  addi sp, sp, 0x50     # release the space

END:
  lis r3, 0x8000           # load empty space in memory
  stw r25, 0x2F4 (r3)      # write 0 if sync'ed, if desynced) to indicated desync in memory
  li r25, 1                # instruction at 80333338
  lwz r3, 0x013c (r26)     # instruction at 8033333c
  cmpw r3, r3              # this should skip the game's desync check
