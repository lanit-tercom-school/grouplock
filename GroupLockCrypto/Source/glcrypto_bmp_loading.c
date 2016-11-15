//
//  loadBMP.h
//  glcrypto
//
//  Created by Kirill Solntsev.
//

#include <stdio.h>
#include <stdlib.h>

int loadBMP(const char *fname, unsigned char **map, unsigned char **head)
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

	*head = (unsigned char*)malloc(begimg);
	*map = (unsigned char*)malloc(size - begimg + 1);
    
	for (int i = 0; i < begimg; i++)
	{
		fread(&buff, sizeof(char), 1, f);
		(*head)[i] = buff;
	}

    while (!feof(f))
	{
		fread(&buff, sizeof(char), 1, f);
		(*map)[i] = buff;
		i++;
	}
	fclose(f);
	return size;
}
