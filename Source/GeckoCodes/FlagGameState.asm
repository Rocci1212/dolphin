#To be inserted at 802849A4
# Flag Game Status
GAME_BEGIN:
  lis r28, 0x8000       # Load 0x80000000 into r28
  cmpwi cr2, r6, 0x9    # Check if GameBegin is being called
  bne+ cr2, GAME_END    # If not, go to next check
  li r4, 0x4            # Load 4 into r4
  stb r4, 0x2FF (r28)   # Store 4 into 0x800002FF
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
  lbz r28, 0x2FF (r28)		# Load flag of game status in r28
  cmpw cr2, r6, r28     # Check the game status
  bne+ cr2, FINALLY     # Get out if the game status is not (cutscenes started)
  lis r28, 0x80c5       
  ori r28, r28, 0xf340  # Load 0x80c5f340 into r28
  lbz r4, 0 (r28)       # Load byte at 0x80c5f340 (Is Online) into r4
  addi r4, r4, 1        # Add 1
  lis r28, 0x8000  			# Load 0x80000000 back into r28
  stb r4, 0x2FF (r28)   # Store 1 into 0x800002FF

FINALLY:
  add r3, r29, r6  			# Original instruction at 0x802849a4



