#To be inserted at 8026382c
# Static immediate loads to r6 and r7 happen write after this,
#   opening these registers up for operations here. For each of these,
#   I'm writing the value in r6 into the address at r7
  stw r9, 0x20 (r30) # original instruction at 8026382c
  lis r6, 0x0        # wipe r6
  lis r7, 0x80C5			
  ori r7, r7, 0xF2D8 # Base address 80c5f2d8 is what we're writing to
  stw r6, 0 (r7)     # Set Camera Type to Static
  stw r6, 4 (r7)     # Set Camera FOV to 1 (all the way zoomed out)
  stw r6, 0x4c (r7)  # Set Item Cheat to None
  stw r6, 0x54 (r7)  # Set Player Cheat to None
  li r6, 0x1         # Load 1 into r6
  stw r6, 0x34 (r7)  # Set Game Mode to First to X
  stw r6, 0x40 (r7)  # Set Series Length to 1
  stw r6, 0x50 (r7)  # Set Stadium Cheat to Secure Stadia
  li r6, 10          # Load dec 10 into r6
  stw r6, 0x3c (r7)  # Set as First to 10

