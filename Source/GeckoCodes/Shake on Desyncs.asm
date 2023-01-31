#To be inserted at 803682EC
START:
  lis r15, 0x8060
  ori r15, r15, 0x0010
  lwz r15, 0(r15)
  cmpwi r15, 1
  bne FINALLY
  lis r15, 0x80CF
  ori r15, r15, 0x7124
  lwz r14, 0(r15)
  cmpwi r14, 0x0
  bne- FINALLY
  lis r14, 0x3D4C
  ori r14, r14, 0xCCCD
  stw r14, 0(r15)

FINALLY:
  stw r0, 20(r1)
