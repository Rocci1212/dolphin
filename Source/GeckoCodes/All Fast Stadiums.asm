#To be inserted at 800081f0
SET_SPEED:
  lis r0, 0x909B        # Using r0 - it gets set after this function anyway
  ori r0, r0, 0x6560    # Load 909B6560 into r0
  cmpw r0, r31          # Compare with r31
  bne- SET_SLIPPERY     # If not equal, go to SET_SLIPPERY
  lis r0, 0x3F26       
  ori r0, r0, 0x6666    # Load 3F266666 into r0 - this value equates to .65 in float
  stw r0, 0xc (r31)     # and store it into 909B656C

SET_SLIPPERY:
  lis r0, 0x909B        
  ori r0, r0, 0x6550    # Set r11 to 909B6550
  cmpw r0, r31          # Compare with r31
  bne- SET_FRICTION     # If not equal, branch to SET_FRICTION
  lis r0, 0x0           # Wipe r0
  stw r0, 0xc (r31)     # Store 0 into 909B655C

SET_FRICTION:
  lis r0, 0x909B        
  ori r0, r0, 0x6540    # Set r11 to 909B6540
  cmpw r0, r31          # Compare with r31
  bne- SET_BOUNCE       # If not equal, branch to SET_BOUNCE
  lis r0, 0x3E4C       
  ori r0, r0, 0xCCCD    # Load 3E4CCCCD into r0 - this value equates to .2 in float
  stw r0, 0xc (r31)     # and store it into 909B654C

SET_BOUNCE:
  lis r0, 0x909B        
  ori r0, r0, 0x6530    # Set r11 to 909B6530
  cmpw r0, r31          # Compare with r31
  bne- END              # Go to end of function
  lis r0, 0x3F19       
  ori r0, r0, 0x999A    # Load 3f19999a into r0 - this value equates to .6 in float
  stw r0, 0xc (r31)     # Store it into 909B6530

FINALLY:                # This function runs a whole lot more than just loading in the stadium terrain
  lwz r31, 0xc (sp)     # Hex to float converter here: https://gregstoll.com/~gregstoll/floattohex/