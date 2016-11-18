//
//  saveBMP.cpp
//  glcrypto
//
//  Created by Kirill Solntsev.
//

#include <stdio.h>

#include "glcrypto_bmp.h"

void saveBMP(const char *indirect, const glcrypto_BYTE *map, const glcrypto_BYTE *head) {
    
	FILE *f;
	int offset;
    int size;
    
	offset = (head[10] << 0) | (head[11] << 8) | (head[12] << 16) | (head[13] << 24);
	size = (head[2] << 0) | (head[3] << 8) | (head[4] << 16) | (head[5] << 24);
	
	f = fopen(indirect, "wb");
	
	fwrite(head, sizeof(unsigned char), offset, f);
	fwrite(map, sizeof(unsigned char), size - offset, f);
 	fclose(f);
}
