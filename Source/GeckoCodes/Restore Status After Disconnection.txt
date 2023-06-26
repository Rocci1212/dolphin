# TODO (IMPORTANT BUGS TO FIX): 
# The first match always starts with green shells, that's because exception vector area is 0 when the game is booted, and 0 means green shell

# This is a C0 code, it runs once per frame (60 times a second)
# Exception vector area usage: 
# 0x1b7 TBD
# 0x1b8 and 0x1b9 for player's scores
# 0x1ba thru 0x1c1 for items
# 0x1c2 for a timer

########### PUSH r14-r31 INTO THE STACK
stwu sp, -0x0050 (sp) #make space for 18 registers
stmw r14, 0x8 (sp) #push r14-r31 onto the stack pointer
###########


# =========================================================================== #
##### PART 1 - CHECK IF CONDITIONS TO ACTIVATE THIS CODE ARE SATISFIED #####
lis r12, 0x8057
lwz r23, 0xFFFFa760 (r12)			# Load pointer to home kritter object
lis r12, 0x80c6
lis r11, 0x8000
lis r10, 0x80cf
lbz r22, 0xFFFFf233	(r12)			# Load SCORE LIMIT
lbz r24, 0x1c2 (r11)			# Load timer (NOT THE MATCH TIMER, a custom timer this code uses to determine whether it's ok to write/read the scores and items or not

lbz r9, 0xFFFFf340 (r12)
cmpwi r9, 1
bne END			# Don't execute code if playing offline

### TIMER STUFF ###
cmpwi r23, 0			# is kritter loaded
bne KRITTER_IS_LOADED
li r24, 240			# if kritter not loaded, set timer to 240
KRITTER_IS_LOADED:

# TODO: ADD CONDITION TO NOT OVERWRITE CURRENT SCORE/ITEMS (but still back them up) IF SAFE MEGASTRIKES CHEAT IS SELECTED
# =========================================================================== #


# =========================================================================== #
##### PART 2 - CHECK IF THERE'S NEED TO RESTORE MATCH STATUS #####
### LOAD CURRENT SCORE/ITEMS ###
lbz r3, 0x58f7 (r10)				# Load current home score
lbz r5, 0x645f (r10)				# Load current away score
lbz r14, 0x597f (r10)				# home item 1
lbz r15, 0x5983 (r10)				# home item 1 quantity
lbz r16, 0x598b (r10)				# home item 2
lbz r17, 0x598f (r10)				# home item 2 quantity
lbz r18, 0x64e7 (r10)				# away item 1
lbz r19, 0x64eb (r10)				# away item 1 quantity
lbz r20, 0x64f3 (r10)				# away item 2
lbz r21, 0x64f7 (r10)				# away item 2 quantity
### CHECK IF IT'S TIME TO RESTORE MATCH STATUS ###
cmpwi r24, 1
bne+ DONT_RESTORE_MATCH_STATUS
# =========================================================================== #


# =============================================to check============================== #
##### PART 3 (OPTIONAL) - RESTORE MATCH STATUS #####
### LOAD THE BACK UP ###
lbz r3, 0x1b8 (r11)				# Load copy of home score 
lbz r5, 0x1b9 (r11)				# Load copy of away score
lbz r14, 0x1ba (r11)				# home item 1
lbz r15, 0x1bb (r11)				# home item 1 quantity
lbz r16, 0x1bc (r11)				# home item 2
lbz r17, 0x1bd (r11)				# home item 2 quantity
lbz r18, 0x1be (r11)				# away item 1
lbz r19, 0x1bf (r11)				# away item 1 quantity
lbz r20, 0x1c0 (r11)				# away item 2
lbz r21, 0x1c1 (r11)				# away item 2 quantity
### FORMAT ITEM VALUES ###
# This part could be removed if, instead of bytes, we use full words to store items in the exception vector area
# this code stores -1 as 0xff to save space, but the game uses int32 for items, so 0xff isn't read as -1, but 255, which is an unknown item ID and makes the game crash
# (0xff must become 0xffffffff otherwise game crashes!) 
cmpwi r14, 0xff
bne+ DONT_FORMAT_A 
li r14, 0xFFFFffff
DONT_FORMAT_A:
cmpwi r16, 0xff
bne+ DONT_FORMAT_B
li r16, 0xFFFFffff
DONT_FORMAT_B:
cmpwi r18, 0xff
bne+ DONT_FORMAT_C 
li r18, 0xFFFFffff
DONT_FORMAT_C:
cmpwi r20, 0xff
bne+ DONT_FORMAT_D 
li r20, 0xFFFFffff
DONT_FORMAT_D:
### STORE IT BACK ###
stb r3, 0x58f7 (r10)				# Update current home score
stb r3, 0x711b (r10)				# Update current home score (visually)
stb r5, 0x645f (r10)				# Update current away score
stb r5, 0x711f (r10)				# Update current away score (visually)
stw r14, 0x597c (r10)				# home item 1
stb r15, 0x5983 (r10)				# home item 1 quantity
stw r16, 0x5988 (r10)				# home item 2
stb r17, 0x598f (r10)				# home item 2 quantity
stw r18, 0x64e4 (r10)				# away item 1
stb r19, 0x64eb (r10)				# away item 1 quantity
stw r20, 0x64f0 (r10)				# away item 2
stb r21, 0x64f7 (r10)				# away item 2 quantity
crclr 22				# set condition register 5 equal to false, this way timer will decrease at the end of this code
b END
# =========================================================================== #


# =========================================================================== #
##### PART 4 (OPTIONAL) - CHECK IF THERE's NEED TO BACK UP MATCH STATUS OR IF IT's TIME TO CLEAR IT #####
DONT_RESTORE_MATCH_STATUS:
cmpwi cr5, r24, 0		# Check if timer==0, this will be used later in the code
cmpw cr6, r22, r3				# compare score limit with home score
cmpw cr7, r22, r5				# compare score limit with away score
beq- cr6, CLEAR_THE_BACKUP
beq- cr7, CLEAR_THE_BACKUP
# =========================================================================== #


# =========================================================================== #
##### PART 5 (OPTIONAL) - BACK UP MATCH STATUS #####
### CHECK IF IT'S SAFE TO COPY THAT DATA ###
bne+ cr5, END				# Check if timer==0 (if it isn't then there's probably some irrelevant data in the score/item addresses)
### COPY CURRENT SCORE/ITEMS INTO THE EXCEPTION VECTOR AREA ###
stb r3, 0x1b8 (r11)				# Update copy of home score 
stb r5, 0x1b9 (r11)				# Update copy of away score
stb r14, 0x1ba (r11)				# home item 1
stb r15, 0x1bb (r11)				# home item 1 quantity
stb r16, 0x1bc (r11)				# home item 2
stb r17, 0x1bd (r11)				# home item 2 quantity
stb r18, 0x1be (r11)				# away item 1
stb r19, 0x1bf (r11)				# away item 1 quantity
stb r20, 0x1c0 (r11)				# away item 2
stb r21, 0x1c1 (r11)				# away item 2 quantity
b END
# =========================================================================== #


# =========================================================================== #
##### PART 6 (OPTIONAL) - CLEAR THE BACK UP #####
# only clear it once and set timer to 240, don't clear it when timer > 0 as there's risk of deleting data that shouldn't be deleted (because the goal addreses load random crap during loading, and if they load a value that's equal to score limit, then the score back up is reset even if there was a disconnection 
CLEAR_THE_BACKUP:			
li r24, 240				# Set timer to 240 every time this instruction is executed, so timer never goes down while scores are equal
bne+ cr5, END				
li r3, 0
lis r5, 0xff00				# 0xff00 because the first byte (0xff) tells the code there's no item. The second byte (0) tells the code there's quantity of 0
ori r5, r5, 0xff00
sth r3, 0x1b8 (r11)				# Clear both scores
sth r5, 0x1ba (r11)				# Clear items	
stw r5, 0x1bc (r11)				# ^
sth r5, 0x1be (r11)				# ^
# =========================================================================== #


# =========================================================================== #
##### PART 7 - END #####
END:
beq+ cr5, DONT_DECREMENT_TIMER
subi r24, r24, 1
DONT_DECREMENT_TIMER:
stb r24, 0x1c2 (r11)			# Store timer back
# =========================================================================== #


########### POP r14-r31 FROM THE STACK
lmw r14, 0x8 (sp) #pop r14-r31 off the stack pointer
addi sp, sp, 0x0050 #release the space
###########
blr

####
