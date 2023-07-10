# This is a C0 code, it runs once per frame

# Players need to be able to check whether their score and items are in sync or not
# What I want to display on screen is: "{scoreH}-{scoreA} {itemH2}{qH2}-{itemH1}{qH1}-{itemA1}{qA1}-{itemA2}{qA2}"
# ==================================================== #
##### PART 1 - SETUP #####
mflr r0			# Back up the link register into r0

### CHECK IF ONLINE ###
lis r12, 0x80c6
lbz r12, 0xFFFFf340 (r12)
cmpwi r12, 1
bne END			# Don't execute code if playing offline

### LOAD TEXT POINTER ###
lis r12, 0x80c2
lwz r12, 0x29d0 (r12)			# Load the pointer to all the text
cmpwi r12, 0			# Check if it's loaded
beq- END
lis r11, 0x2
add r12, r12, r11			# add 0x20000 because the offset we need is really far

# ==================================================== #
##### PART 2 - CHEAT TEXT #####
bl BRANCH_LINK_1
.long 0x52455354 		#REST
.long 0x4F524520 		#ORE 
.long 0x53544154 		#STAT
.long 0x55530054 		#US(null)T
.long 0x4F20484F 		#O HO
.long 0x57204954 		#W IT	
.long 0x20574153 		# WAS
.long 0x20424546 		# BEF
.long 0x4F524520 		#ORE
.long 0x44495343 		#DISC
.long 0x4F4E4E45 		#ONNE
.long 0x4354494E 		#CTIN
.long 0x47000000		 #G(null)
BRANCH_LINK_1:
mflr r11
mr r10, r12			# Copy the value of r12 into r10
SAFEMEGA_LOOP:
lbz r3, 0 (r11)			# Load the next character from the branch link trick
addi r11, r11, 1			# increment r11 by 1 to point to the next character of the branch link trick
sth r3, 0xFFFFfdec (r10)	# Store a null followed by the character in the place you need to store it
addi r10, r10, 2			# increment r10 by 2, to point to the next character to write
cmpwi r3, 0			# Check if last character was a null. If it was then exit the loop
bne+ SAFEMEGA_LOOP
# ---------------------------------------------------- #
### PART 2B - "ONLY KRITTER CAN STOP A MEGASTRIKE" ###
lis r9, 0x1			
add r10, r12, r9			# Value in r10 = value in r12 + 0x10000 (we need to do this because the next offset we need is really far)
ONLYKRITTER_LOOP:
lbz r3, 0 (r11)			# Load the next character from the branch link trick
addi r11, r11, 1			# increment r11 by 1 to point to the next character of the branch link trick
sth r3, 0xFFFFd2a8 (r10)	# Store a null followed by the character in the place you need to store it
addi r10, r10, 2			# increment r10 by 2, to point to the next character to write
cmpwi r3, 0			# Check if last character was a null. If it was then exit the loop
bne+ ONLYKRITTER_LOOP
# ==================================================== #
##### PART 3 - SCORES #####
# NOTE: This won't work with scores above 9, but there's no need for that anyway, so I'll never fix it
lis r10, 0x8000
# Write home score
lbz r3, 0x1cc (r10)				
addi r3, r3, 0x30
sth r3, 0xFFFFd0ca (r12)
# Write "-" character
li r3, 0x2d				
sth r3, 0xFFFFd0cc (r12)				
# Write away score
lbz r3, 0x1cd (r10)				
addi r3, r3, 0x30
sth r3, 0xFFFFd0ce (r12)
# Write space character
li r3, 0x20		
sth r3, 0xFFFFd0d0 (r12)

# ==================================================== #
##### PART 4 - ITEMS :mscwariodizzy: #####
# I use the branch link trick here. Learn how it works here: https://mariokartwii.com/showthread.php?tid=977
bl BRANCH_LINK_2
.long 0x4772656E			#Gren ID:0
.long 0x52656420 			#Red  ID:1
.long 0x5370696E 			#Spin ID:2
.long 0x426C7565 			#Blue ID:3
.long 0x42616E61 			#Bana ID:4
.long 0x426F6D62 			#Bomb ID:5
.long 0x43686D70 			#Chmp ID:6
.long 0x5368726D 			#Shrm ID:7
.long 0x53746172 			#Star ID:8
.long 0x43617074 			#Capt
.long 0x4E4F4E45			#NONE
BRANCH_LINK_2:
# ---------------------------------------------------- #
# IMPORTANT: From now on, link register will always have the address of ".long 0x4772656E"	and we'll use r11 to point to other ".long" addresses
addi r10, r10, 0x1b8			# r10 now points to 0x800001b8: the address of first home item quantity
li r9, 7			# r9 value = 7. r9 Will be an important register to keep track if the loop's current state. r10+r9 will always point to the item ID
ITEM_LOOP:
mflr r11			# Copy value of link register into r11. 
add r5, r10, r9			# r5 will temporarily become the sum of r9+r10, this way it will point to the item ID
lbz r5, 0 (r5)			# Load item ID
cmpwi cr0, r5, 0xff
cmpwi cr1, r5, 0x9
blt+ cr1, ITS_NOT_CAPTAIN
li r5, 0x9
ITS_NOT_CAPTAIN:
bne+ cr0, ITS_NOT_NONE
li r5, 0xa
ITS_NOT_NONE:
mulli r5, r5, 4
add r11, r11, r5			# Add to the value in r11 the value of the item ID multiplied by 4. This way r11 will point to the correct item text
# ---------------------------------------------------- #
# Now it's time to write the item name
lbz r3, 0x0 (r11)
sth r3, 0xFFFFd0d2 (r12)
lbz r3, 0x1 (r11)
sth r3, 0xFFFFd0d4 (r12) 
lbz r3, 0x2 (r11)
sth r3, 0xFFFFd0d6 (r12) 
lbz r3, 0x3 (r11)
sth r3, 0xFFFFd0d8 (r12) 
# Store quantity number
lbz r3, 0 (r10)
addi r3, r3, 0x30
sth r3, 0xFFFFd0da (r12)
# Write "-" character
li r3, 0x2d				
sth r3, 0xFFFFd0dc (r12)	
# ---------------------------------------------------- #

# Loop conditions and counters
addi r10, r10, 0x1			# increase r10 by 1, so it will point to next item's quantity.
addi r9, r9, 0x3			# increase r9 by 3, so r9+r10 will point to next item.
addi r12, r12, 0xc			# increase r12 by 12, so it will point to the next string of text
cmpwi r9, 0x11			# check if r9 is now bigger than r10, if it is than that means the 4th iteration of the loop just concluded
blt+ ITEM_LOOP
# Write null character to end the string
li r3, 0x0				
sth r3, 0xFFFFd0d2 (r12)	
# ==================================================== #


END:
mtlr r0			# Restore link register's original value
blr


###