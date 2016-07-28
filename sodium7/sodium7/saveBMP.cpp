#include "iostream"
#include "windows.h"
#include "atlimage.h"

using namespace std;

void saveBMP(wchar_t *indirect, HBITMAP hBmp)
{
	CImage img;
	LPWSTR indirectstr;
	indirectstr = indirect;
	img.Attach(hBmp);
	img.Save(indirectstr);
}