# To be inserted at 8033338c
  lis r3, 0x8000
  ori r3, r3, 2       # load 80000002 into r3
  stb r3, 0x2fd (r3)  # store at 0x800002ff
  li r3, 16           # original instruction at 8033338c