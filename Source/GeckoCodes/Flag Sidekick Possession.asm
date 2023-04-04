#To be inserted at 800966f8
# in this code, i am moving r30 to r0 for storage, and then back to r30 at the end
# r0 gets wiped after this anyway, so it's free to use
mr r0, r30
cmpwi r31, 0 # make sure possession is being flagged (as opposed to dispossession which sets r31 to 0)
beq SKICK_BALL
lis r30, 0x8056
ori r30, r30, 0xa740 # location of home captain player object
lwz r30, 0 (r30)
cmpw r30, r0 # compare if the pointer in r30 equals the pointer in r0 from the original function
beq CAPT_BALL
lis r30, 0x8056
ori r30, r30, 0xa750 # location of away captain player object
lwz r30, 0 (r30) 
cmpw r30, r0 # compare if the pointer in r30 equals the pointer in r0 from the original function
beq CAPT_BALL

SKICK_BALL:
lis r30, 0x8060
stb r30, 0x10 (r30)
b 0x10

CAPT_BALL:
lis r30, 0x8060
ori r30, r30, 0x01
stb r30, 0xf (r30)

FINALLY:
mr r30, r0
stw r31, 0x0310 (r30)
