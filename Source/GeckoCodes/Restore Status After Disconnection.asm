# This is a C0 code, it runs once per frame (60 times a second)
# Exception vector area usage: 
# 0x1b7 The code reads this value, and if it's 0 it resets the score/item copy and sets that value to 0xff
# 0x1b8 thru 0x1bb for item quantities
# 0x1bc thru 0x1cb for items
# 0x1cc and 0x1cd for player's scores
# 0x1ce for a timer that starts counting down during the loading of an online match and tells the code to wait until it has reached 0

START:
########### PUSH r14-r31 INTO THE STACK
  stwu sp, -0x0050 (sp) #make space for 18 registers
  stmw r14, 0x8 (sp) #push r14-r31 onto the stack pointer
###########

# =========================================================================== #
##### PART 1 - CHECK IF CONDITIONS TO ACTIVATE THIS CODE ARE SATISFIED #####
  lis r12, 0x806e
  lwz r23, 0xFFFFf9d8 (r12)			# Load pointer to match status struct
  lis r12, 0x80c6
  lis r11, 0x8000
  lbz r22, 0xFFFFf233	(r12)			# Load SCORE LIMIT
  lbz r24, 0x1ce (r11)			# Load timer (NOT THE MATCH TIMER, a custom timer this code uses to determine whether it's ok to write/read the scores and items or not
  
### CLEAR THE BACK UP ###
  lis r30, 0				# r30 = 0
  subi r31, r30, 1				# r31 = -1
  lbz r29, 0x1b7 (r11)
  cmpwi r29, 0				# if the value at 0x1b7 is 0, set it to 0xff and clear the copy of items/score
  bne+ DONT_CLEAR_BACKUP
  stb r31, 0x1b7 (r11)
  stw r30, 0x1b8 (r11)
  stw r31, 0x1bc (r11)
  stw r31, 0x1c0 (r11)
  stw r31, 0x1c4 (r11)
  stw r31, 0x1c8 (r11)
  sth r30, 0x1cc (r11)

DONT_CLEAR_BACKUP:


### CHECK IF ONLINE ###
  lbz r9, 0xFFFFf340 (r12)
  cmpwi r9, 1
  bne END			# Don't execute code if playing offline
  
### CHECK IF STRUCT LOADED ###
  cmpwi r23, 0			# is struct loaded
  bne- STRUCT_IS_LOADED
  li r24, 240			# if struct not loaded, set timer to 240
  b DONT_DECREMENT_TIMER

STRUCT_IS_LOADED:
# =========================================================================== #


# =========================================================================== #
##### PART 2 - CHECK IF THERE'S NEED TO RESTORE MATCH STATUS #####
### LOAD CURRENT SCORE/ITEMS ###
  lbz r3, 0x7 (r23)				# Load current home score
  lbz r5, 0xb6f (r23)				# Load current away score
  lwz r14, 0x8c (r23)				# home item 1
  lbz r15, 0x93 (r23)				# home item 1 quantity
  lwz r16, 0x98 (r23)				# home item 2
  lbz r17, 0x9f (r23)				# home item 2 quantity
  lwz r18, 0xbf4 (r23)				# away item 1
  lbz r19, 0xbfb (r23)				# away item 1 quantity
  lwz r20, 0xc00 (r23)				# away item 2
  lbz r21, 0xc07 (r23)				# away item 2 quantity
### CHECK IF IT'S TIME TO RESTORE MATCH STATUS ###
  cmpwi r24, 1
  bne+ DONT_RESTORE_MATCH_STATUS
# =========================================================================== #

# =========================================================================== #
##### PART 3 (OPTIONAL) - RESTORE MATCH STATUS #####
### CHECK IF SAFE MEGASTRIKES SELECTED ###
  crclr 22				# set condition register 5 equal bit to false, this way timer will decrease at the end of this code
  lbz r28, 0xFFFFf29f (r12)
  cmpwi r28, 2				# Check if safe megas selected. if it is then restore match status
  bne+ END
### LOAD THE BACK UP ###
  lbz r3, 0x1cc (r11)				# Load copy of home score 
  lbz r5, 0x1cd (r11)				# Load copy of away score
  lwz r14, 0x1bc (r11)				# home item 1
  lbz r15, 0x1b8 (r11)				# home item 1 quantity
  lwz r16, 0x1c0 (r11)				# home item 2
  lbz r17, 0x1b9 (r11)				# home item 2 quantity
  lwz r18, 0x1c4 (r11)				# away item 1
  lbz r19, 0x1ba (r11)				# away item 1 quantity
  lwz r20, 0x1c8 (r11)				# away item 2
  lbz r21, 0x1bb (r11)				# away item 2 quantity
### STORE IT BACK ###
  stb r3, 0x7 (r23)				# Update current home score
  stb r3, 0x182b (r23)				# Update current home score (visually)
  stb r5, 0xb6f (r23)				# Update current away score
  stb r5, 0x182f (r23)				# Update current away score (visually)
  stw r14, 0x8c (r23)				# home item 1
  stb r15, 0x93 (r23)				# home item 1 quantity
  stw r16, 0x98 (r23)				# home item 2
  stb r17, 0x9f (r23)				# home item 2 quantity
  stw r18, 0xbf4 (r23)				# away item 1
  stb r19, 0xbfb (r23)				# away item 1 quantity
  stw r20, 0xc00 (r23)				# away item 2
  stb r21, 0xc07 (r23)				# away item 2 quantity
  b END
# =========================================================================== #


# =========================================================================== #
##### PART 4 (OPTIONAL) - CHECK IF THERE's NEED TO BACK UP MATCH STATUS OR IF IT's TIME TO CLEAR IT #####
DONT_RESTORE_MATCH_STATUS:
  cmpwi cr5, r24, 0		# Check if timer==0, this will be used later in the code
  cmpw cr6, r22, r3				# compare score limit with home score
  cmpw cr7, r22, r5				# compare score limit with away score
  beq- cr6, MATCH_COMPLETED
  beq- cr7, MATCH_COMPLETED
# =========================================================================== #


# =========================================================================== #
##### PART 5 (OPTIONAL) - BACK UP MATCH STATUS #####
### CHECK IF IT'S SAFE TO COPY THAT DATA ###
  bne+ cr5, END				# Check if timer==0 (if it isn't then there's probably some irrelevant data in the score/item addresses)
### COPY CURRENT SCORE/ITEMS INTO THE EXCEPTION VECTOR AREA ###
  stb r3, 0x1cc (r11)				# Update copy of home score 
  stb r5, 0x1cd (r11)				# Update copy of away score
  stw r14, 0x1bc (r11)				# home item 1
  stb r15, 0x1b8 (r11)				# home item 1 quantity
  stw r16, 0x1c0 (r11)				# home item 2
  stb r17, 0x1b9 (r11)				# home item 2 quantity
  stw r18, 0x1c4 (r11)				# away item 1
  stb r19, 0x1ba (r11)				# away item 1 quantity
  stw r20, 0x1c8 (r11)				# away item 2
  stb r21, 0x1bb (r11)				# away item 2 quantity
  b END
# =========================================================================== #


# =========================================================================== #
##### PART 6 (OPTIONAL) - CLEAR THE BACK UP #####
# only clear it once and set timer to 240, don't clear it when timer > 0 as there's risk of deleting data that shouldn't be deleted (because the goal addreses load random crap during loading, and if they load a value that's equal to score limit, then the score back up is reset even if there was a disconnection 
MATCH_COMPLETED:
  li r24, 240				# Set timer to 240 every time this instruction is executed, so timer never goes down while scores are equal
  bne+ cr5, END
  stb r30, 0x1b7 (r11)				# Setting this byte to 0 will make this code reset the copy of items/score on the next frame			
# =========================================================================== #


# =========================================================================== #
##### PART 7 - END #####
END:
  beq+ cr5, DONT_DECREMENT_TIMER
  subi r24, r24, 1

DONT_DECREMENT_TIMER:
  stb r24, 0x1ce (r11)			# Store timer back
# =========================================================================== #


########### POP r14-r31 FROM THE STACK
  lmw r14, 0x8 (sp) #pop r14-r31 off the stack pointer
  addi sp, sp, 0x0050 #release the space
###########
  blr 

####
