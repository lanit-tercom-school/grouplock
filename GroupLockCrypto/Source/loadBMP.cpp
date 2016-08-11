#include "iostream"

using namespace std;

BITMAP loadBMP(wchar_t *fname, HBITMAP &hBmp)
{
	BITMAP bmp;

	LPWSTR fn;
	fn = fname;
	hBmp = (HBITMAP)LoadImage(GetModuleHandle(0), fn,
		IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE);
	GetObjectW(hBmp, sizeof(BITMAP), &bmp);

	return bmp;
}
