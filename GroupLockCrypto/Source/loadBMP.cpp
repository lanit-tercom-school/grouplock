//
//  loadBMP.h
//  glcrypto
//
//  Created by Kirill Solntsev.
//

#include "iostream"

using namespace std;

int loadBMP(const char *fname, unsigned char *&map, unsigned char *&head)
{
	char buff;
	FILE *f;
	int begimg;
	int i = 0;
	f = fopen(fname, "rb");
	long int size = 0;
	fseek(f, 0, SEEK_END);
	size = ftell(f);
	fseek(f, 10, SEEK_SET);
	fread(&begimg, sizeof(int), 1, f);
	fseek(f, 0, SEEK_SET);

	head = new unsigned char[begimg];
	map = new unsigned char[size - begimg];
	for (int i = 0; i < begimg; i++)
	{
		fread(&buff, sizeof(char), 1, f);
		head[i] = buff;
	}
	while (!feof(f))
	{
		fread(&buff, sizeof(char), 1, f);
		map[i] = buff;
		i++;
	}
	fclose(f);
	return size;
}
