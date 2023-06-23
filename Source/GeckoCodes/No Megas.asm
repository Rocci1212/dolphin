#To be inserted at 800FCA80
# Updates to be made to this
# I need to know if I'm online or offline
# If offline, this code works fine
# If online, that is to say, word? at 80c5f340 = 1
# Then I need to set 80c5f29c to 3, not 80c5f304 as below
SHOT_RELEASE:
  # I use a technique called Pushing/Popping the stack here, as shown here:
  # https://mariokartwii.com/showthread.php?tid=873
  stwu sp, -0x0050 (sp) # make space for 18 registers
  stmw r14, 0x8 (sp)    # push r14-r31 onto the stack pointer

CHECK_VERSUS_MODE:
  lis r14, 0x80c5
  ori r14, r14, 0xf33f  # set r14 to 80c5f33f
  lbz r14, 0 (r14)      # are we in versus mode? is this gonna be 1 for in-game ranked matches?
  cmpwi r14, 0          # versus mode = 0
  bne CLEAN_UP          # if not, get outta here



  lbz r14, 0x2fe(r14)		 # set r14 now to the byte at 0x800002fe (location that flags captain possession)
  cmpwi r14, 0x0        # does the sidekick have the ball?
  lis r15, 0x80c5			
  ori r15, r15, 0xf340  # load 0x80c5f340 into r15 (address contains value of whether we're online)
  lwz r15, 0 (r15)      # store the value there
  bne CLASSIC_MODE
  lis r3, 0x80C5
  ori r3, r3, 0xF300
  stb r3, 7(r3)
  b CLEAN_UP

CLASSIC_MODE:
  lis r3, 0x80C5
  ori r3, r3, 0xF304
  stb r3, 3(r3)

CLEAN_UP:
  lmw r14, 0x8 (sp)     # pop r14-r31 off the stack pointer
  addi sp, sp, 0x50     # release the space
  lwz r3, 8(r3)

