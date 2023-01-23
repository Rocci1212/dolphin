#To be inserted at 8004246c
# Flag Sidekick Possession
lis r15, 0x8060
lis r14, 0x8050
ori r14, r14, 0xcd40
cmpw r5, r14
lis r14, 0x0
beq- CAPT_BALL
lis r14, 0x804d
ori r14, r14, 0xb528
cmpw r5, r14
lis r14, 0x0
beq- SKICK_BALL

CAPT_BALL:
stb r14, 1(r15)
b 0xc

SKICK_BALL:
ori r14, r14, 0xa
stb r14, 1(r15)

FINALLY:
lwz r0, 0x4 (r3)