
//
//  decryptBMP.cpp
//  glcrypto
//
//  Created by Kirill Solntsev.
//

#include "sodium.h"
#include "glcrypto_bmp.h"

void decryptBMP(const char *fname,
                glcrypto_byte *nonce,
                glcrypto_byte *key) {

    // TODO: Handle returned result
	sodium_init();
	
	glcrypto_byte *map;
	glcrypto_byte *head;
	
	int sizeOfBait;
	sizeOfBait = loadBMP(fname, &map, &head);
	
	glcrypto_byte *ciphertext;
	ciphertext = (glcrypto_byte*)malloc(sizeOfBait);

	crypto_stream_salsa20_xor(ciphertext, map, sizeOfBait, nonce, key);

	saveBMP("decrypt.bmp", ciphertext, head);
}
