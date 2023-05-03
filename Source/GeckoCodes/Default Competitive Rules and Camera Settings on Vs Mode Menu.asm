#To be inserted at 802337C8
# Static immediate loads to r28 and r27 happen write after this,
#   opening these registers up for operations here. For each of these,
#   I'm writing the value in r28 into the address at r27
  stmw r27, 12 (r1)     # original instruction at 802337c8
  lis r28, 0x0          # wipe r28
  lis r27, 0x80C5			
  ori r27, r27, 0xF2D8  # Base address 80c5f2d8 is what we're writing to
  stw r28, 0 (r27)      # Set Camera Type to Static
  stw r28, 4 (r27)      # Set Camera FOV to 1 (all the way zoomed out)
  stw r28, 0x24 (r27)   # Set Item Cheat to None
  stw r28, 0x2c (r27)   # Set Player Cheat to None
  li r28, 0x1           # Load 1 into r28
  stw r28, 0xc (r27)    # Set Game Mode to First to X
  stw r28, 0x18 (r27)   # Set Series Length to 1
  stw r28, 0x28 (r27)   # Set Stadium Cheat to Secure Stadia
  li r28, 10            # Load dec 10 into r28
  stw r28, 0x14 (r27)   # Set as First to 10