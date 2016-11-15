
//
//  decryptBMP.cpp
//  glcrypto
//
//  Created by Kirill Solntsev.
//

#include "sodium.h"
#include "glcrypto_bmp_loading.h"
#include "glcrypto_bmp_saving.h"

void decryptBMP(const char *fname,
                unsigned char nonce[crypto_secretbox_NONCEBYTES],
                unsigned char key[crypto_secretbox_KEYBYTES])
{

    // TODO: Handle returned result
	sodium_init();
	
	unsigned char *map;
	unsigned char *head;
	
	int sizeOfBait;
	sizeOfBait = loadBMP(fname, &map, &head);
	
	unsigned char *ciphertext;
	ciphertext = (unsigned char*)malloc(sizeOfBait);

	crypto_stream_salsa20_xor(ciphertext, map, sizeOfBait, nonce, key);

	saveBMP("decrypt.bmp", ciphertext, head);
}
