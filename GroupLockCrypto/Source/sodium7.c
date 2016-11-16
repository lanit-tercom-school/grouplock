//
//  sodium7.cpp
//  glcrypto
//
//  Created by Kirill Solntsev.
//

#include "sodium.h"
#include "glcrypto_bmp.h"
#include "glcrypto.h"

int main()
{
	unsigned char nonce[crypto_secretbox_NONCEBYTES];
	unsigned char key[crypto_secretbox_KEYBYTES];

	encryptBMP("pict.bmp", nonce, key);

	decryptBMP("encrypt.bmp", nonce, key);

#if defined(WIN32) || defined(WIN64)
	system("pause");
#endif

	return 0;
}
