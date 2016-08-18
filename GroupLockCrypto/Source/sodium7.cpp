//
//  sodium7.cpp
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
#include "encryptBMP.h"
#include "decryptBMP.h"

using namespace std;

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
