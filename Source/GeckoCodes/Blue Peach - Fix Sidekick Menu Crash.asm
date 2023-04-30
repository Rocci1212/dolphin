#To be inserted at 801C51F0
loc_0x0:
  stw r29, 8(r3)
  lis r3, 0x8050
  addi r3, r3, 0x4ECC
  cmpwi r29, 0x3
  bne- loc_0x1C
  li r4, 0x4
  b loc_0x20

loc_0x1C:
  li r4, 0x5

loc_0x20:
  stw r4, 0(r3)
