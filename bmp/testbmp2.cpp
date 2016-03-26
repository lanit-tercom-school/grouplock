#include  <stdio.h>
#include "stdafx.h"
#include <iostream>
#include "BMP.h"


BITMAPFILEHEADER bitmapFileHeader;
BITMAPINFOHEADER bitmapInfoHeader;


//серый фильтр
void grey(BITMAPINFOHEADER bitmapInfoHeader, BITMAPFILEHEADER bitmapFileHeader, Color **bitecolor)
{
	int R, G, B, Y;

	for (int i = 0; i < bitmapInfoHeader.biHeight; i++)
		for (int j = 0; j < bitmapInfoHeader.biWidth; j++)
		{
			R = bitecolor[i][j].rgbtRed;
			G = bitecolor[i][j].rgbtGreen;
			B = bitecolor[i][j].rgbtBlue;
			Y = (R + G + B) / 3;
			bitecolor[i][j].rgbtRed = Y;
			bitecolor[i][j].rgbtGreen = Y;
			bitecolor[i][j].rgbtBlue = Y; 
		}
	createbmp(bitmapInfoHeader, bitmapFileHeader, bitecolor); //создаем итоговый файл
}


int main()
{
	//открываем файл
	FILE *file;
	file = fopen("tank.bmp", "rb"); 
	if (file == NULL)
	{
		printf("Error name\n");
	}
	//выставляем на начало
	fseek(file, 0, SEEK_SET);
	//читаем структуры
	fread(&bitmapFileHeader, sizeof(BITMAPFILEHEADER), 1, file);
	fread(&bitmapInfoHeader, sizeof(BITMAPINFOHEADER), 1, file);

	//возвращает RGB
	bitecolor = readbmp(bitmapInfoHeader, bitmapFileHeader, file); 

	grey(bitmapInfoHeader, bitmapFileHeader, bitecolor);

	return 0;
}

