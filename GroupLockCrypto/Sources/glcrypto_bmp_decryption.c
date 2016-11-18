
//
//  decryptBMP.cpp
//  glcrypto
//
//  Created by Kirill Solntsev.
//

#include "sodium.h"
#include "glcrypto_bmp.h"

void decryptBMP(const char *fname,
                glcrypto_BYTE *nonce,
                glcrypto_BYTE *key) {

    // TODO: Handle returned result
	sodium_init();
	
	glcrypto_BYTE *map;
	glcrypto_BYTE *head;
	
	int sizeOfBait;
	sizeOfBait = loadBMP(fname, &map, &head);
	
	glcrypto_BYTE *ciphertext;
	ciphertext = malloc(sizeOfBait);

	crypto_stream_salsa20_xor(ciphertext, map, sizeOfBait, nonce, key);

	saveBMP("resources/decrypted_lena.bmp", ciphertext, head);
}
