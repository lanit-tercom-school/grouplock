// sodium7.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include "libsodium1010msvc\include\sodium.h"
#include "string"
#include "iostream"
#include "loadbmp.h"
#include "sstream"
#include "savebmp.h"
#include "atlimage.h"
#include "encryptBMP.h"
//#include "nouncekey.h"
#include "decryptBMP.h"

;using namespace std;

int main()
{
	unsigned char nonce[crypto_secretbox_NONCEBYTES];
	unsigned char key[crypto_secretbox_KEYBYTES];
	encryptBMP(
		_T("D:/pict.bmp"),
		nonce,key);

	decryptBMP(_T("D:/encrypt.bmp"), nonce, key);

	system("pause");


	return 0;
}

