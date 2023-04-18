loc_0x0:
  stfs f0, 12(r31)
  lis r11, 0x909B
  ori r11, r11, 0x6560
  cmpw r31, r11
  bne- loc_0x20
  lis r12, 0x3F26
  ori r12, r12, 0x6666
  stw r12, 12(r31)

loc_0x20:
  subi r11, r11, 0x10
  cmpw r31, r11
  bne- loc_0x34
  lis r12, 0x0
  stw r12, 12(r31)

loc_0x34:
  subi r11, r11, 0x10
  cmpw r31, r11
  bne- loc_0x4C
  lis r12, 0x3E4C
  ori r12, r12, 0xCCCD
  stw r12, 12(r31)

loc_0x4C:
  subi r11, r11, 0x10
  cmpw r31, r11
  bne- loc_0x64
  lis r12, 0x3F19
  ori r12, r12, 0x999A
  stw r12, 12(r31)

loc_0x64:

