//#include "nouncekey.h"

void encryptBMP(
	wchar_t *fname, 
	unsigned char nonce[crypto_secretbox_NONCEBYTES],
	unsigned char key[crypto_secretbox_KEYBYTES]);