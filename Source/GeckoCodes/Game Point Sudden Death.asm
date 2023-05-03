#To be inserted at 802c6908
stwu sp, -0x0050 (sp) # make space for 18 registers
stmw r14, 0x8 (sp)    # push r14-r31 onto the stack pointer

lis r14, 0x8060
lbz r14, 1 (r14)
cmpwi cr2, r14, 1
lis r14, 0x8005
ori r14, r14, 0xa6bc
bne cr2, NO_SD

YES_SD:
lis r15, 0x6000
stw r15, 0 (r14)
b FINALLY

NO_SD:
lis r15, 0xc05f
ori r15, r15, 0x1c
stw r15, 0 (r14)

FINALLY:
lmw r14, 0x8 (sp)     # pop r14-r31 off the stack pointer
addi sp, sp, 0x50     # release the space
lwz r3, -0x1538 (r13)