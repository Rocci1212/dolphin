#To be inserted at 803332D8
# Mark Desyncs
# Code should write a value to memory when the game desyncs
  cmplw	r3, r0 # our original instruction is a compare
  lis r14, 0x8060 # load empty space in memory
  beq WEGOOD # skip this step if our CRCs are in sync
  li r15, 1 # runs only if CRCs not in sync
  b END
WEGOOD:
  li r15, 0
END:
  stw r15, 0x10(r14) # write r15 (0 if sync'ed, 1 if desynced) to indicate desync in memory
  lis r14, 0 # wipe r14
  lis r15, 0 # wipe r15
  cmpw r14, r15 # this should skip the game's desync check