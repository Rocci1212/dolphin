#To be inserted at 8011982C
# Flag On Game Start
loc_0x0:
  li r14, 0x1       # Load 0x00000001 into r14
  lis r15, 0x8060   # Load 0x80600000 into r15
  stb r14, 0(r15)   # Store 1 into 0x80600000
  lis r14, 0x0      # Wipe r14
  lis r15, 0x0      # Wipe r15
  lwz r4, 0x80(r4)  # Original instruction at 0x8011982C
