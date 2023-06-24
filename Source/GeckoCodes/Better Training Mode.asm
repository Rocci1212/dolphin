loc_0x0:
  lis r12, 0x8058
  lhz r11, 24290(r12)
  lis r12, 0x8000
  cmpwi r11, 0x110
  bne+ loc_0x1C
  li r10, 0x2
  stb r10, 438(r12)

loc_0x1C:
  cmpwi r11, 0x1100
  bne+ loc_0x2C
  li r10, 0x1
  stb r10, 438(r12)

loc_0x2C:
  cmpwi r11, 0x500
  beq- loc_0xFC
  lis r9, 0x80C6
  lbz r10, -3264(r9)
  cmpwi r10, 0x1
  beq+ loc_0xFC
  lbz r10, 438(r12)
  cmpwi r10, 0x0
  beq+ loc_0xFC
  lis r5, 0x0
  stb r5, -3541(r9)
  lis r9, 0x80CF
  stw r5, 20728(r9)
  cmpwi r10, 0x1
  lis r12, 0x8057
  beq- loc_0xB4
  lwz r9, -22704(r12)
  lwz r10, -22700(r12)
  lwz r11, -22696(r12)
  lwz r12, -22692(r12)
  cmpwi r12, 0x0
  beq- loc_0xFC
  lis r5, 0x41B0
  stw r5, 1488(r12)
  stw r5, 1488(r11)
  stw r5, 1488(r10)
  lis r5, 0x0
  stw r5, 1488(r9)
  lis r5, 0x4100
  stw r5, 1492(r12)
  stw r5, 1492(r11)
  stw r5, 1492(r10)
  stw r5, 1492(r9)
  b loc_0x108

loc_0xB4:
  lwz r9, -22720(r12)
  lwz r10, -22716(r12)
  lwz r11, -22712(r12)
  lwz r12, -22708(r12)
  cmpwi r12, 0x0
  beq- loc_0xFC
  lis r5, 0xC1B0
  stw r5, 1488(r12)
  stw r5, 1488(r11)
  stw r5, 1488(r10)
  lis r5, 0x0
  stw r5, 1488(r9)
  lis r5, 0x4100
  stw r5, 1492(r12)
  stw r5, 1492(r11)
  stw r5, 1492(r10)
  stw r5, 1492(r9)
  b loc_0x108

loc_0xFC:
  lis r12, 0x8000
  li r3, 0x0
  stb r3, 438(r12)

loc_0x108:
  blr 
  .word 0x00000000
  lfs f0, 0(r0)
  .word 0x0000001e
  lis r9, 0x8000
  lbz r3, 438(r9)
  cmpwi r3, 0x0
  beq+ loc_0x204
  lis r12, 0x8058
  lhz r11, 24290(r12)
  lbz r5, 5456(r9)
  lbz r10, 5457(r9)
  cmpwi r5, 0xFF
  bne- loc_0x144
  li r5, 0xFFFF

loc_0x144:
  cmpwi r10, 0x0
  bne- loc_0x150
  li r10, 0x1

loc_0x150:
  lbz r12, 5458(r9)
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
  stb r5, 5456(r9)
  stb r10, 5457(r9)
  stb r12, 5458(r9)
  li r11, 0xFFFF
  lis r12, 0x80CF
  cmpwi r3, 0x1
  beq- loc_0x1F8
  stw r5, 22908(r12)
  stw r10, 22912(r12)
  stw r11, 25828(r12)
  b loc_0x204

loc_0x1F8:
  stw r5, 25828(r12)
  stw r10, 25832(r12)
  stw r11, 22908(r12)

loc_0x204:
  blr 

