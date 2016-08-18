#include "iostream"

using namespace std;

void saveBMP(char *indirect, unsigned char *map, unsigned char *head)
{
	FILE *f;
	int offset;
	offset = (head[10] << 0) | (head[11] << 8) | (head[12] << 16) | (head[13] << 24);
	int size;
	size = (head[2] << 0) | (head[3] << 8) | (head[4] << 16) | (head[5] << 24);
	
	f = fopen(indirect, "wb");
	
	fwrite(head, sizeof(unsigned char), offset, f);
	fwrite(map, sizeof(unsigned char), size - offset, f);
 	fclose(f);
}