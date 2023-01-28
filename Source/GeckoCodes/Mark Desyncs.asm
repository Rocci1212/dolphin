#To be inserted at 803332D8
# Mark Desyncs
# Code should write a value to memory when the game desyncs
  cmplw	r3, r0 # our original instruction is a compare
  beq END # skip this step if our CRCs are in sync
  lis r14, 0x8060 # load empty space in memory
  li r15, 1
  stw r15, 0x10(r14) # write 1 to indicate desync in memory
END:
  lis r14, 0 # wipe r14
  lis r15, 0 # wipe r15
  cmpw r14, r15 # this should skip the game's desync check