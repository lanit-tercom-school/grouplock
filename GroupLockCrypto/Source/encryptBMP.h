#include "sodium.h"


void encryptBMP(
	char *fname, 
	unsigned char nonce[crypto_secretbox_NONCEBYTES],
	unsigned char key[crypto_secretbox_KEYBYTES]);