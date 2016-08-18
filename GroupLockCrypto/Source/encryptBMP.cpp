//
//  encryptBMP.cpp
//  glcrypto
//
//  Created by Kirill Solntsev.
//


#include "stdafx.h"
#include "sodium.h"
#include "string"
#include "iostream"
#include "loadbmp.h"
#include "savebmp.h"
#include <fstream>


using namespace std;
void encryptBMP(const char *fname,
                unsigned char nonce[crypto_secretbox_NONCEBYTES],
                unsigned char key[crypto_secretbox_KEYBYTES])
{
	// TODO: Handle returned result
	sodium_init();

	randombytes_buf(nonce, sizeof nonce);
	randombytes_buf(key, sizeof key);

	unsigned char *map = nullptr;
	unsigned char *head = nullptr;

	int sizeOfBait;
	sizeOfBait = loadBMP(fname, map, head);

	unsigned char *ciphertext;
	ciphertext = new unsigned char[sizeOfBait];
	
	crypto_stream_salsa20_xor(ciphertext, map, sizeOfBait, nonce, key);

	saveBMP("encrypt.bmp", ciphertext, head);
}
