//
//  loadBMP.h
//  glcrypto
//
//  Created by Kirill Solntsev.
//

#include <stdio.h>
#include <stdlib.h>

#include "glcrypto_bmp.h"

int loadBMP(const char *fname, glcrypto_byte **map, glcrypto_byte **head) {
    
	char buff;
	FILE *f;
	int begimg;
	int i;
    
	f = fopen(fname, "rb");
	long int size = 0;
	fseek(f, 0, SEEK_END);
	size = ftell(f);
	fseek(f, 10, SEEK_SET);
	fread(&begimg, sizeof(int), 1, f);
	fseek(f, 0, SEEK_SET);

	*head = (glcrypto_byte*)malloc(begimg);
	*map = (glcrypto_byte*)malloc(size - begimg + 1);
    
	for (int i = 0; i < begimg; i++) {
		fread(&buff, sizeof(char), 1, f);
		(*head)[i] = buff;
	}

    i = 0;
    
    while (!feof(f)) {
		fread(&buff, sizeof(char), 1, f);
		(*map)[i] = buff;
		i++;
	}
    
	fclose(f);
    
	return size;
}
