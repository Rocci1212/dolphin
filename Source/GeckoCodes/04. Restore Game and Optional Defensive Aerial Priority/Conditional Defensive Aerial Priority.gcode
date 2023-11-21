041118CC 3BBDA740		// replace instruction at 801118cc (subi r29, r29, 0x58C0) with: subi r29, r29, 0x58C0
041118EC 3BBD0004		// replace instruction at 801118ec (addi r29, r29, 0x4) with: addi r29, r29, 0x4 (i also don't know why this is here)
48000000 806DF7A0		// set pointer to 806df7a0
DE000000 80008180		// check if pointer >= 80000000 and <= 81800000
38000218 7FFF0000		// basically checks if pointer + 0x218 = 0000
280001fe FF000001		// check if 800001fe = 1 | this is the line in need to change to get csl stadia to be def priority
041118CC 3BBDA764		// if so, replace instruction at 801118cc (subi r29, r29, 0x58C0) with subi r29, r29, 0x589C
041118EC 3BBDFFFC		// replace instruction at 801118ec (addi r29, r29, 0x4) with subi r29, r29, 0x4
E0000000 80008000		// full terminator