//
//  encryptBMP.cpp
//  glcrypto
//
//  Created by Kirill Solntsev.
//


#include "sodium.h"
#include "glcrypto_bmp.h"

void encryptBMP(const char *fname,
                glcrypto_BYTE *nonce,
                glcrypto_BYTE *key) {
	sodium_init();

	randombytes_buf(nonce, sizeof nonce);
	randombytes_buf(key, sizeof key);

	glcrypto_BYTE *map;
	glcrypto_BYTE *head;

	int sizeOfBait;
	sizeOfBait = loadBMP(fname, &map, &head);

	glcrypto_BYTE *ciphertext;
	ciphertext = malloc(sizeOfBait);
	
	crypto_stream_salsa20_xor(ciphertext, map, sizeOfBait, nonce, key);

	saveBMP("resources/encrypted_lena.bmp", ciphertext, head);
}
