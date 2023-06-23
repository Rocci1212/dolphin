#To be inserted at 800FCA80
# Updates to be made to this
# I need to know if I'm online or offline
# If offline, this code works fine
# If online, that is to say, word? at 80c5f340 = 1
# Then I need to set 80c5f29c to 3, not 80c5f304 as below
SHOT_RELEASE:
  mr r0, r3
  lis r3, 0x8060
  ori r3, r3, 0
  lhz r3, 0x10(r3)
  cmpwi r3, 0x0
  bne CLASSIC_MODE
  lis r3, 0x80C5
  ori r3, r3, 0xF300
  stb r3, 7(r3)
  b CLEAN_UP

CLASSIC_MODE:
  lis r3, 0x80C5
  ori r3, r3, 0xF304
  stb r3, 3(r3)

CLEAN_UP:
  mr r3, r0
  lwz r3, 8(r3)
