#To be inserted at 802784A8
# Used at [$Recommended: Blue Peach vs Red or Orange Opponents] at R4QP01.ini
loc_0x0:
  lwz r5, 0(r28)
  cmpwi r5, 0x5
  bne+ loc_0x10
  li r3, 0x0

loc_0x10:
  cmpwi r3, 0x0
