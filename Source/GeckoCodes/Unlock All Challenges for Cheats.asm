#To be inserted at 8010F63C
  lis r3, 0
  ori r3, r3, 0xffff  # Load 0xFFFF into r3
  stw r3, 0x68 (r31)  # Store it into r31 + 0x68