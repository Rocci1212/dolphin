loc_0x0:
  lis r9, 0x8000
  lbz r3, 438(r9)
  cmpwi r3, 0x0
  beq+ loc_0xEC
  lis r12, 0x8058
  lhz r11, 24290(r12)
  lbz r5, 5456(r9)
  lbz r10, 5457(r9)
  cmpwi r5, 0xFF
  bne- loc_0x2C
  li r5, 0xFFFF

loc_0x2C:
  cmpwi r10, 0x0
  bne- loc_0x38
  li r10, 0x1

loc_0x38:
  lbz r12, 5458(r9)
  cmpwi r12, 0x0
  bne- loc_0xA4
  cmpwi r11, 0x101
  bne+ loc_0x5C
  subi r5, r5, 0x1
  cmpwi r5, 0xFFFE
  bne- loc_0x5C
  li r5, 0x14

loc_0x5C:
  cmpwi r11, 0x102
  bne+ loc_0x74
  addi r5, r5, 0x1
  cmpwi r5, 0x15
  bne- loc_0x74
  li r5, 0xFFFF

loc_0x74:
  cmpwi r11, 0x104
  bne+ loc_0x8C
  subi r10, r10, 0x1
  cmpwi r10, 0x0
  bne- loc_0x8C
  li r10, 0x19

loc_0x8C:
  cmpwi r11, 0x108
  bne+ loc_0xA4
  addi r10, r10, 0x1
  cmpwi r10, 0x1A
  bne- loc_0xA4
  li r10, 0x1

loc_0xA4:
  li r12, 0x0
  andi. r0, r11, 0xF
  beq+ loc_0xB4
  li r12, 0x1

loc_0xB4:
  stb r5, 5456(r9)
  stb r10, 5457(r9)
  stb r12, 5458(r9)
  li r11, 0xFFFF
  lis r12, 0x80CF
  cmpwi r3, 0x1
  beq- loc_0xE0
  stw r5, 22908(r12)
  stw r10, 22912(r12)
  stw r11, 25828(r12)
  b loc_0xEC

loc_0xE0:
  stw r5, 25828(r12)
  stw r10, 25832(r12)
  stw r11, 22908(r12)

loc_0xEC:
  blr 

