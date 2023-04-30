#To be inserted at 8005A6BC
loc_0x0:
  lis r12, 0x80C6     # Load 80c60000 into r12
  lhz r11, -3534(r12) # Load value at 80c5F232 (Score Limit) into r11
  lhz r10, 25786(r12) # Load value at 80c664BA (Score 1) into r10
  subi r11, r11, 0x1  # Subtract 1 from r11 and store it in r11
  cmpw r11, r10       # Compare with r10
  bne- loc_0x30       # If not equal, it's not sudden death, branch to end
  lhz r9, 25784(r12)  # Load value at 80c664B9 (Score 2) into r9
  cmpw r10, r9        # Compare Score 1 with Score 2
  bne- loc_0x30       # Branch if not equal
  lis r11, 0x4396     # Load 43960000 into r11
  lis r12, 0x80CF     # Load 80cf0000 into r12
  stw r11, 20728(r12) # Store 43960000 into 80cf50f8

loc_0x30:
  lfs f2, 28(r31)     # Original instruction at 8005a6bc

