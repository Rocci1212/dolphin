#To be inserted at 802B57C4
# Flag On Game Quit
loc_0x0:
  li r14, 0x0       # Wipe r14
  lis r15, 0x8060   # Load 0x80600000 into r15
  stb r14, 0(r15)   # Store 0 into 0x80600000
  lis r14, 0x0      # Wipe r14
  lis r15, 0x0      # Wipe r15
  stw r5, 0(r3)     # Original instruction at 0x802B57C4
