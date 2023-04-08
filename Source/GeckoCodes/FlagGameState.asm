#To be inserted at 802849a4
# Flag Game Status
GAME_BEGIN:
  lis r28, 0x8060  # Load 0x80600000 into r28
  cmpwi r6, 0x9    # Check if GameBegin is being called
  bne+ GAME_END    # If not, go to next check
  li r4, 0x4       # Load 4 into r4
  stb r4, 0 (r28)  # Store 4 into 0x80600000
  b FINALLY        # Go to original instruction

GAME_END:
  cmpwi r6, 0x12   # Check if GameEndSuddenDeath is being called
  bne+ IDLE_START  # If not, go to next check
  li r4, 0x0       # Load 0 into r4
  stb r4, 0 (r28)  # Store 0 into 0x80600000
  b FINALLY        # Go to original instruction

IDLE_START:
  cmpwi r6, 4      # Check if Idle is being called
  bne+ FINALLY     # If not, go to end of function
  lbz r28, 0 (r28) # Load flag of game status in r28
  cmpw r6, r28     # Check the game status
  bne+ FINALLY     # Get out if the game status is not (cutscenes started)
  lis r28, 0x8060  # Load 0x80600000 back into r28
  li r4, 0x1       # Load 1 into r4
  stb r4, 0 (r28)  # Store 1 into 0x80600000
  bne+ GAME_END    # If not, go to next check

FINALLY:
  add r3, r29, r6  # Original instruction at 0x802849a4

