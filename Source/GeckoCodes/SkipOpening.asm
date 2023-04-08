#To be inserted at 80286c5c
IS_OPENING_PLAYING:
  mtlr r3
  lis r3, 0x8060
  lbz r3, 0 (r3)
  cmpwi r3, 0x4
  mflr r3
  lis r0, 0x8028
  bne IS_NOT_OPENING

IS_OPENING:
  ori r0, r0, 0x6c64
  b 0x8

IS_NOT_OPENING:
  ori r0, r0, 0x6c60

FINALLY:
  mtlr r0
  blr
