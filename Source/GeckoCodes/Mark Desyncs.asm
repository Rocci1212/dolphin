#To be inserted at 803332D8
# Mark Desyncs
# Code should write a value to memory when the game desyncs
  cmplw	r3, r0        # our original instruction is a compare
  lis r14, 0x8060     # load empty space in memory
  beq WEGOOD          # skip this step if our CRCs are in sync
  li r25, 1           # runs only if CRCs not in sync - store 1 in memory
  b END
WEGOOD:
  li r25, 0           # there's no issue - store this in memory
END:
  stw r25, 0x10(r3)   # write r25 (0 if sync'ed, 1 if desynced) to indicate desync in memory
  lis r25, 1          # wipe r14
  lwz r3, 0x11c (r26) # wipe r15
  cmpw r3, r3         # this should skip the game's desync check