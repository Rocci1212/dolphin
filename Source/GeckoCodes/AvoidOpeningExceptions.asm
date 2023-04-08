#To be inserted at 8027b518
IS_OPENING_PLAYING:
  lis r31, 0x8060
  lbz r31, 0 (r31)
  cmpwi r31, 0x4
  lis r31, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  ori r31, r31, 0xb528
  b 0x8

IS_NOT_OPENING:
  ori r31, r31, 0xb51c

FINALLY:
  mtlr r31
  mr r31, r3
  stw r28, 0x10 (sp)
  blr

#To be inserted at 8027b528
IS_OPENING_PLAYING:
  lis r31, 0x8060
  lbz r31, 0 (r31)
  cmpwi r31, 0x4
  lis r31, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  ori r31, r31, 0xb530
  b 0x8

IS_NOT_OPENING:
  ori r31, r31, 0xb52c

FINALLY:
  mtlr r31
  mr r31, r3
  stb r0, -0x6660 (r13)
  blr

#To be inserted at 8027b540
IS_OPENING_PLAYING:
  lis r3, 0x8060
  lbz r3, 0 (r3)
  cmpwi r3, 0x4
  lis r3, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  ori r3, r3, 0xb548
  b 0x8

IS_NOT_OPENING:
  ori r3, r3, 0xb544

FINALLY:
  mtlr r3
  addis r3, r31, 3
  lfs f0, -0x53e8 (rtoc)
  blr

#To be inserted at 8027b55c
IS_OPENING_PLAYING:
  lis r3, 0x8060
  lbz r3, 0 (r3)
  cmpwi r3, 0x4
  lis r3, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  ori r3, r3, 0xb564
  b 0x8

IS_NOT_OPENING:
  ori r3, r3, 0xb560

FINALLY:
  mtlr r3
  lis r3, 0x8057
  blr

#To be inserted at 8027b564
IS_OPENING_PLAYING:
  lis r4, 0x8060
  lbz r4, 0 (r4)
  cmpwi r4, 0x4
  lis r4, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  ori r4, r4, 0xb56c
  b 0x8

IS_NOT_OPENING:
  ori r4, r4, 0xb568

FINALLY:
  mtlr r4
  addis r4, r31, 3
  addi r3, r3, 2680
  blr