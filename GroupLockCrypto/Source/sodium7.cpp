// sodium7.cpp: определяет точку входа для консольного приложения.
//

#include "sodium.h"
#include "iostream"
#include "loadbmp.h"
#include "sstream"
#include "savebmp.h"
#include "atlimage.h"
#include "encryptBMP.h"
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

#if defined(_WIN32) || defined(_WIN64)
	system("pause");
#endif
	return 0;
}
