//
//  encryptBMP.cpp
//  glcrypto
//
//  Created by Kirill Solntsev.
//


#include "sodium.h"
#include "glcrypto_bmp_loading.h"
#include "glcrypto_bmp_saving.h"

void encryptBMP(const char *fname,
                unsigned char *nonce,
                unsigned char *key)
{
	sodium_init();

	randombytes_buf(nonce, sizeof nonce);
	randombytes_buf(key, sizeof key);

	unsigned char *map;
	unsigned char *head;

	int sizeOfBait;
	sizeOfBait = loadBMP(fname, &map, &head);

	unsigned char *ciphertext;
	ciphertext = (unsigned char*)malloc(sizeOfBait);
	
	crypto_stream_salsa20_xor(ciphertext, map, sizeOfBait, nonce, key);

	saveBMP("encrypt.bmp", ciphertext, head);
}
