#To be inserted at 80251EEC
loc_0x0:
  cmpwi r0, 0x1
  bne- loc_0xC
  li r0, 0x0

loc_0xC:
  stb r0, 142(r4)
