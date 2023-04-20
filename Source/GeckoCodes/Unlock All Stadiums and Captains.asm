#To be inserted at 8010F71C
  lis r0, 0
  ori r0, r0, 0xffff    # load 0xffff into r0
  sth r0, -0x7954 (r3)  # store 0xffff into r3 - 0x7954
