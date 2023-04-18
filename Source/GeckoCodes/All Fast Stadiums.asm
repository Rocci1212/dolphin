#To be inserted at 800081EC
SET_SPEED:
  stfs f0, 0xc (r31)    # initial instruction at 800081EC
  lis r11, 0x909B       # Using r11 - is this ever reset at the end?
  ori r11, r11, 0x6560  # Load 909B6560 into r11
  cmpw r31, r11         # Compare with r31
  bne- SET_SLIPPERY     # If not equal, go to SET_SLIPPERY
  lis r12, 0x3F26       # Using r12 - is this ever reset at the end?
  ori r12, r12, 0x6666  # Load 3F266666 into r12
  stw r12, 0xc (r31)    # Store 3F266666 into 909B656C - this value equates to .65 in float

SET_SLIPPERY:
  subi r11, r11, 0x10   # Set r11 to 909B6550
  cmpw r31, r11         # Compare with r31
  bne- SET_FRICTION     # If not equal, branch to SET_FRICTION
  lis r12, 0x0          # Wipe r12
  stw r12, 0xc (r31)    # Store 0 into 909B655C

SET_FRICTION:
  subi r11, r11, 0x10   # Set r11 to 909B6540
  cmpw r31, r11         # Compare with r31
  bne- SET_BOUNCE       # If not equal, branch to SET_BOUNCE
  lis r12, 0x3E4C       
  ori r12, r12, 0xCCCD  # Load 3E4CCCCD into r12
  stw r12, 0xc (r31)    # Store 3E4CCCCD into 909B654C - this value equates to .2 in float

SET_BOUNCE:
  subi r11, r11, 0x10   # Set r11 to 909B6530
  cmpw r31, r11         # Compare with r31
  bne- END              # Go to end of function - this is going to leave r11 at 909B6530 at exit time
  lis r12, 0x3F19       
  ori r12, r12, 0x999A  # Load 3f19999a into r12
  stw r12, 0xc (r31)    # Store it into 909B6530 - this value equates to .6 in float

END:                    # This function runs a whole lot more than just loading in the stadium terrain
                        # Some concerns: the value of r11 and possibly r12 is overridden no matter what.
                        # I'm not sure what those are used for, but it could be causing some issues.
                        # r0 and r31 are much safer to use, as they're overridden right after the insertion address
                        # Though I guess this means we lose the ability to use r31 in the way we're using it here.
                        # I tried breaking when 909B6560 is loaded in r31, and manually setting these values on Vice,
                        # but it was still slow. Function labels are a guess, I don't know how these values convert
                        # to .65 / 0 / .2 / .6 from the ini file
                        # Hex to float converter here: https://gregstoll.com/~gregstoll/floattohex/