#To be inserted at 801EE6D0
# Flag On Game Restart
loc_0x0:
  li r14, 0x1           # Load 0x00000001 into r14
  lis r15, 0x8060       # Load 0x80600000 into r15
  stb r14, 0(r15)       # Store 1 into 0x80600000
  lis r14, 0x0          # Wipe r14
  lis r15, 0x0          # Wipe r15
  lwz r3, -0x2488(r13)  # Original instruction at 0x801EE6D0
