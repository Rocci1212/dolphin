loc_0x0:
  lis r12, 0x8058
  lhz r11, 0x5ee2 (r12)
  lis r12, 0x8000
  cmpwi r11, 0x110
  bne+ loc_0x1C
  li r10, 0x2
  stb r10, 0x1b6 (r12)

loc_0x1C:
  cmpwi r11, 0x1100
  bne+ loc_0x2C
  li r10, 0x1
  stb r10, 0x1b6 (r12)

loc_0x2C:
  cmpwi r11, 0x500
  beq- loc_0xFC
  lis r9, 0x80C6
  lbz r10, 0xfffff340 (r9) # hoping this translates to -3264 in base 10
  cmpwi r10, 0x1
  beq+ loc_0xFC
  lbz r10, 0x1b6 (r12)
  cmpwi r10, 0x0
  beq+ loc_0xFC
  lis r5, 0x0
  stb r5, 0xffffF22B (r9) # hoping this translates to -3541 in base 10
  lis r9, 0x80CF
  stw r5, 0x50F8 (r9)
  cmpwi r10, 0x1
  lis r12, 0x8057
  beq- loc_0xB4
  lwz r9, 0xffffA750 (r12) # hoping this translates to -22704 in base 10
  lwz r10, 0xffffA754 (r12) # hoping this translates to -22700 in base 10
  lwz r11, 0xffffA758 (r12) # hoping this translates to -22696 in base 10
  lwz r12, 0xffffA75C (r12) # hoping this translates to -22692 in base 10
  cmpwi r12, 0x0
  beq- loc_0xFC
  lis r5, 0x41B0
  stw r5, 0x5D0 (r12)
  stw r5, 0x5D0 (r11)
  stw r5, 0x5D0 (r10)
  lis r5, 0x0
  stw r5, 0x5D0 (r9)
  lis r5, 0x4100
  stw r5, 0x5D4 (r12)
  stw r5, 0x5D4 (r11)
  stw r5, 0x5D4 (r10)
  stw r5, 0x5D4 (r9)
  b loc_0x108

loc_0xB4:
  lwz r9, 0xffffA740 (r12) # hoping this translates to -22720 in base 10
  lwz r10, 0xffffA744 (r12) # hoping this translates to -22716 in base 10
  lwz r11, 0xffffA748 (r12) # hoping this translates to -22712 in base 10
  lwz r12, 0xffffA74C (r12) # hoping this translates to -22708 in base 10
  cmpwi r12, 0x0
  beq- loc_0xFC
  lis r5, 0xC1B0
  stw r5, 0x5D0 (r12)
  stw r5, 0x5D0 (r11)
  stw r5, 0x5D0 (r10)
  lis r5, 0x0
  stw r5, 0x5D0 (r9)
  lis r5, 0x4100
  stw r5, 0x5D4 (r12)
  stw r5, 0x5D4 (r11)
  stw r5, 0x5D4 (r10)
  stw r5, 0x5D4 (r9)
  b loc_0x108

loc_0xFC:
  lis r12, 0x8000
  li r3, 0x0
  stb r3, 0x1b6 (r12)

loc_0x108:
  blr 
  .word 0x00000000
  lfs f0, 0 (r0)
  .word 0x0000001e
  lis r9, 0x8000
  lbz r3, 0x1b6 (r9)
  cmpwi r3, 0x0
  beq+ loc_0x204
  lis r12, 0x8058
  lhz r11, 0x5EE2 (r12)
  lbz r5, 0x1550 (r9)
  lbz r10, 0x1551 (r9)
  cmpwi r5, 0xFF
  bne- loc_0x144
  li r5, 0xFFFF

loc_0x144:
  cmpwi r10, 0x0
  bne- loc_0x150
  li r10, 0x1

loc_0x150:
  lbz r12, 0x1552 (r9)
  cmpwi r12, 0x0
  bne- loc_0x1BC
  cmpwi r11, 0x101
  bne+ loc_0x174
  subi r5, r5, 0x1
  cmpwi r5, 0xFFFE
  bne- loc_0x174
  li r5, 0x14

loc_0x174:
  cmpwi r11, 0x102
  bne+ loc_0x18C
  addi r5, r5, 0x1
  cmpwi r5, 0x15
  bne- loc_0x18C
  li r5, 0xFFFF

loc_0x18C:
  cmpwi r11, 0x104
  bne+ loc_0x1A4
  subi r10, r10, 0x1
  cmpwi r10, 0x0
  bne- loc_0x1A4
  li r10, 0x19

loc_0x1A4:
  cmpwi r11, 0x108
  bne+ loc_0x1BC
  addi r10, r10, 0x1
  cmpwi r10, 0x1A
  bne- loc_0x1BC
  li r10, 0x1

loc_0x1BC:
  li r12, 0x0
  andi. r0, r11, 0xF
  beq+ loc_0x1CC
  li r12, 0x1

loc_0x1CC:
  stb r5, 0x1550 (r9)
  stb r10, 0x1551 (r9)
  stb r12, 0x1552 (r9)
  li r11, 0xFFFF
  lis r12, 0x80CF
  cmpwi r3, 0x1
  beq- loc_0x1F8
  stw r5, 0x597C (r12)
  stw r10, 0x5980 (r12)
  stw r11, 0x64E4 (r12)
  b loc_0x204

loc_0x1F8:
  stw r5, 0x64E4 (r12)
  stw r10, 0x64E8 (r12)
  stw r11, 0x597C (r12)

loc_0x204:
  blr 

