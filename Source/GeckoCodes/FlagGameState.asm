#To be inserted at 802849A4
# Flag Game Status
GAME_BEGIN:
  lis r28, 0x8000       # Load 0x80000000 into r28
  cmpwi cr2, r6, 0x9    # Check if GameBegin is being called
  bne+ cr2, GAME_END    # If not, go to next check
  li r4, 0x4            # Load 4 into r4
  stb r4, 0x2FF (r28)   # Store 4 into 0x800002FF

GET_IS_ONLINE:
  lis r4, 0x80c5
  ori r4, r4, 0xf340    # load 80c5f340 into r4
  lbz r4, 0 (r4)        # load the value in (0 if off-line, 1 if online)
  cmpwi cr3, r4, 0      # are we online, or offline? store it in condition register 3
  lis r4, 0x80c5        # get ready for finding the address of the player cheat

GET_PLAYER_CHEAT_OFFLINE:
  bne cr3, GET_PLAYER_CHEAT_ONLINE  # if r4 = 1, then we're online, get the value there
  ori r4, r4, 0xf307    
  lbz r4, 0 (r4)        # load value in the player cheats (offline) into memory
  b STORE_PLAYER_CHEAT  # go to place where we store it

GET_PLAYER_CHEAT_ONLINE:
  ori r4, r4, 0xf29f    
  lbz r4, 0 (r4)        # load value in the player cheats (online) into memory
  b STORE_PLAYER_CHEAT  # go to place where we store it

STORE_PLAYER_CHEAT:
  stb r4, 0x2fd (r28)   # Store Player Cheat into 0x800002FD
  b FINALLY             # Go to original instruction

GAME_END:
  cmpwi cr2, r6, 0x12   # Check if GameEndSuddenDeath is being called
  bne+ cr2, IDLE_START  # If not, go to next check
  li r4, 0x0       	    # Load 0 into r4
  stb r4, 0x2FF (r28)  	# Store 0 into 0x800002FF
  b FINALLY        	    # Go to original instruction

IDLE_START:
  cmpwi cr2, r6, 4      # Check if Idle is being called
  bne+ cr2, FINALLY     # If not, go to end of function
  lbz r28, 0x2FF (r28)	# Load flag of game status in r28
  cmpw cr2, r6, r28     # Check the game status
  bne+ cr2, FINALLY     # Get out if the game status is not (cutscenes started)
  lis r28, 0x8000  			# Load 0x80000000 back into r28
  li r4, 0x1       			# Load 1 into r4
  stb r4, 0x2FF (r28)   # Store 1 into 0x800002FF

FINALLY:
  add r3, r29, r6  			# Original instruction at 0x802849a4
