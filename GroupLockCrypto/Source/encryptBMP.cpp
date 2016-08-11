#include "sodium.h"
#include "iostream"
#include "loadbmp.h"
#include "sstream"
#include "savebmp.h"

using namespace std;
void encryptBMP(
	wchar_t *fname,
	unsigned char nonce[crypto_secretbox_NONCEBYTES],
	unsigned char key[crypto_secretbox_KEYBYTES])
{
	//��� �� ���������� � ��� �� ���� ������ �����
	sodium_init();

	randombytes_buf(nonce, sizeof nonce);
	randombytes_buf(key, sizeof key);

	BITMAP bmp;
	HBITMAP hBmp;
	LPVOID *map;

	bmp = loadBMP(fname, hBmp);
	int sizeOfBait = bmp.bmHeight*bmp.bmWidth*bmp.bmBitsPixel / 8;
	int sizeOfPixel = bmp.bmHeight*bmp.bmWidth;

	map = new LPVOID[sizeOfPixel];

	unsigned char *ciphertext;
	ciphertext = new unsigned char[sizeOfBait];

	GetBitmapBits(hBmp, sizeOfBait, map);

	crypto_stream_salsa20_xor(ciphertext,
		(unsigned char *)map, sizeOfBait, nonce, key);

	SetBitmapBits(hBmp, sizeOfBait, (LPVOID *)ciphertext);

	saveBMP(_T("D:\\encrypt.bmp"), hBmp);

}
