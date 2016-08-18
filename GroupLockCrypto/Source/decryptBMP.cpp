#include "stdafx.h"
#include "sodium.h"
#include "string"
#include "iostream"
#include "loadbmp.h"
#include "savebmp.h"

using namespace std;

void decryptBMP(
	char *fname, 
	unsigned char nonce[crypto_secretbox_NONCEBYTES],
	unsigned char key[crypto_secretbox_KEYBYTES])
{
	sodium_init();
	
    
	unsigned char *map = nullptr;
	unsigned char *head = nullptr;
	
	int sizeOfBait;
	sizeOfBait = loadBMP(fname, map, head);
	
	unsigned char *ciphertext;
	ciphertext = new unsigned char[sizeOfBait];

	crypto_stream_salsa20_xor(ciphertext, map, sizeOfBait, nonce, key);

	saveBMP("decrypt.bmp", ciphertext, head);
}