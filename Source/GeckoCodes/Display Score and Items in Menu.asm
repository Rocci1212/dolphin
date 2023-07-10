# To be inserted at 8023B1EC
BEGIN:
########### PUSH r14-r31 INTO THE STACK
  stwu sp, -0x0050 (sp) # make space for 18 registers
  stmw r14, 0x8 (sp)    # push r14-r31 onto the stack pointer

  #mflr r14              # back up the link register to r14 don't think i need this

  # r15 = pointer to the constants array
  # r16 = cursor in constants array to write
  # r17 = cursor traversing the BL trick
  # r18 = ascii value of chracter to write


  lis r15, 0x80C2       
  ori r15, r15, 0x29D0  # load 80c229d0 into r15

  lwz r15, 0 (r15)      # grab it's value since it's a pointer to a pointer
  lis r16, 0x1          
  ori r16, r16, 0xFDEC
  add r16, r15, r16     # offset it by 1d0ca (location of SEASON TIME text)

##### CHEAT TEXT ######
  bl BRANCH_LINK_1
  .long 0x52455354 		# REST
  .long 0x4F524520 		# ORE 
  .long 0x53544154 		# STAT
  .long 0x55530054 		# US(null)T
  .long 0x4F20484F 		# O HO
  .long 0x57204954 		# W IT	
  .long 0x20574153 		# WAS
  .long 0x20424546 		# BEF
  .long 0x4F524520 		# ORE
  .long 0x44495343 		# DISC
  .long 0x4F4E4E45 		# ONNE
  .long 0x4354494E 		# CTIN
  .long 0x47000000		# G(null)

BRANCH_LINK_1:
  mflr r17           

SAFEMEGA_LOOP:
  lbz r18, 0 (r17)   # load the next character from the branch link trick
  addi r17, r17, 1   # increment r17 by 1 to point to the next character of the branch link trick
  sth r18, 0 (r16)   # store a null followed by the character in the place you need to store it
  addi r16, r16, 2   # increment r16 by 2 to point to the next character to write
  cmpwi cr2, r18, 0  # check if last character was a null - if so, exit the loop
  bne cr2, SAFEMEGA_LOOP  

##### CHEAT SUB TEXT #####
  lis r16, 2
  ori r16, r16, 0xd2a8  # set r16 to it's new offset
  add r16, r15, r16     # set r16 to the offset + pointer to constants array

ONLYKRITTER_LOOP:
  lbz r18, 0 (r17)      # load the next character from the branch link trick
  addi r17, r17, 1      # increment r17 by 1 to point to the next character of the branch link trick
  sth r18, 0 (r16)      # store a null followed by the character in the place you need to store it
  addi r16, r16, 2      # increment r16 by 2 to point to the next character to write
  cmpwi cr2, r18, 0     # check if last character was a null - if so, exit the loop
  bne cr2, ONLYKRITTER_LOOP

SCORES:
  # note: we don't have the room to store scores greater than 9
  lis r19, 0x8000       # point r19 to exception area where game status variables are kept
  lis r16, 0x1          
  ori r16, r16, 0xd0ca
  add r16, r15, r16     # offset it by 1d0ca (location of SEASON TIME text)

  # write home score
  lbz r18, 0x1cc (r19)
  addi r18, r18, 0x30

  mtlr r0               # link register is backed up at 802eb1e0 which is nice for saving a line of code

########### POP r14-r31 FROM THE STACK
  lmw r14, 0x8 (sp)     # pop r14-r31 off the stack pointer
  addi sp, sp, 0x0050   # release the space

  mr r30, r3            # original instruction at 8023B1EC

