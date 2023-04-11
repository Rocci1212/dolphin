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
  fsubs f1, f1, f1
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
  fsubs f1, f1, f1
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
  fsubs f0, f0, f0
  ori r4, r4, 0xb56c
  b 0x8

IS_NOT_OPENING:
  ori r4, r4, 0xb568

FINALLY:
  mtlr r4
  addis r4, r31, 3
  addi r3, r3, 2680
  blr

#To be inserted at 8027b57c - this one is crashing
IS_OPENING_PLAYING:
  lis r30, 0x8060
  lbz r30, 0 (r30)
  cmpwi r30, 0x4
  lis r30, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  li r3, 0  # i don't know why i have to do this
  ori r30, r30, 0xb584 # i don't know why i'm skipping to here
  b 0x8

IS_NOT_OPENING:
  ori r30, r30, 0xb580

FINALLY:
  mtlr r30
  li r30, 0
  blr

#To be inserted at 8027b5a0
IS_OPENING_PLAYING:
  lis r4, 0x8060
  lbz r4, 0 (r4)
  cmpwi r4, 0x4
  lis r4, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  ori r4, r4, 0xb5ac
  b 0x8

IS_NOT_OPENING:
  lis r3, 0
  ori r4, r4, 0xb5a4

FINALLY:
  mtlr r4
  addis r4, r29, 3
  blr

#To be inserted at 8027b5dc
IS_OPENING_PLAYING:
  lis r3, 0x8060
  lbz r3, 0 (r3)
  cmpwi r3, 0x4
  lis r3, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  fsubs f0, f0, f0
  ori r3, r3, 0xb5e4
  b 0x8

IS_NOT_OPENING:
  ori r3, r3, 0xb5e0

FINALLY:
  mtlr r3
  lfs f1, -0x53e8 (rtoc)
  blr

#To be inserted at 8027b604
IS_OPENING_PLAYING:
  lis r3, 0x8060
  lbz r3, 0 (r3)
  cmpwi r3, 0x4
  lis r3, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  fsubs f0, f0, f0
  ori r3, r3, 0xb60c
  b 0x8

IS_NOT_OPENING:
  ori r3, r3, 0xb608

FINALLY:
  mtlr r3
  lfs f1, -0x53e8 (rtoc)
  blr

#To be inserted at 8027b618
IS_OPENING_PLAYING:
  lis r3, 0x8060
  lbz r3, 0 (r3)
  cmpwi r3, 0x4
  lis r3, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  fsubs f1, f1, f1
  ori r3, r3, 0xb620
  b 0x8

IS_NOT_OPENING:
  ori r3, r3, 0xb61c

FINALLY:
  mtlr r3
  addis r3, r31, 3
  blr

#To be inserted at 8027b628
IS_OPENING_PLAYING:
  lis r3, 0x8060
  lbz r3, 0 (r3)
  cmpwi r3, 0x4
  lis r3, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  lis r0, 0
  ori r3, r3, 0xb630
  b 0x8

IS_NOT_OPENING:
  ori r3, r3, 0xb62c

FINALLY:
  mtlr r3
  addis r3, r31, 3
  blr

#To be inserted at 8027b644
IS_OPENING_PLAYING:
  lis r3, 0x8060
  lbz r3, 0 (r3)
  cmpwi r3, 0x4
  lis r3, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  lis r0, 0
  ori r3, r3, 0xb64c
  b 0x8

IS_NOT_OPENING:
  ori r3, r3, 0xb648

FINALLY:
  mtlr r3
  addis r3, r31, 3
  lfs f0, -0x53e8 (rtoc)
  blr

#To be inserted at 8027b64c
IS_OPENING_PLAYING:
  lis r4, 0x8060
  lbz r4, 0 (r4)
  cmpwi r4, 0x4
  lis r4, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  ori r4, r4, 0xb688
  b 0x8

IS_NOT_OPENING:
  ori r4, r4, 0xb650

FINALLY:
  mtlr r4
  li r4, 0
  blr

#To be inserted at 8027b690
IS_OPENING_PLAYING:
  lis r4, 0x8060
  lbz r4, 0 (r4)
  cmpwi r4, 0x4
  lis r4, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  ori r4, r4, 0xb69c
  b 0x8

IS_NOT_OPENING:
  ori r4, r4, 0xb694

FINALLY:
  mtlr r4
  li r4, 1
  blr

#To be inserted at 8027a574
IS_OPENING_PLAYING:
  lis r3, 0x8060
  lbz r3, 0 (r3)
  cmpwi r3, 0x3
  lis r3, 0x8027
  bne IS_NOT_OPENING

IS_OPENING:
  lis r3, 0
  ori r3, r3, 0xa57c
  b 0x8

IS_NOT_OPENING:
  ori r3, r3, 0xa578

FINALLY:
  mtlr r3
  addis r3, r4, 3
  blr