#To be inserted at 80275070
loc_0x0:
  lwz r5, 0(r29)
  cmpwi r5, 0x5
  bne+ loc_0x10
  li r3, 0x0

loc_0x10:
  cmpwi r3, 0x0
