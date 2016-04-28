
#pragma pack(push, 1) //размер выравнивания в 1 байт, описали структуру и вернули предыдущую настройку. Думаю с этим не будет проблем. Иначе будем побайтово считывать файл и вручную записывать данные


typedef struct tagRGBQUAD {

	unsigned char rgbtBlue;      // Составляющая B-голубого цвета
	unsigned char rgbtGreen;     // Составляющая G-зеленого цвета   
	unsigned char rgbtRed;       // Составляющая R-красного цвета      
	//unsigned char  rgbtReserved;
} Color;

typedef struct tagBITMAPFILEHEADER {
	short bfType;                            // Тип файла, должен быть BM
	int bfSize;                              // Размер файла в байтах
	short bfReserved1;                       // Зарезервированное поле
	short bfReserved2;                       // Зарезервированное поле
	int bfOffBits;                           // Смещение битового массива относительно начала файла.
}BITMAPFILEHEADER;

typedef struct tagBITMAPINFOHEADER {
	int biSize;                           // Размер структуры. (равен 40)
	int biWidth;                          // Ширина изображения в пикселах.
	int biHeight;                         // Высота изображения в пикселах.
	short biPlanes;                       // Количество плоскостей. (должно быть 1)
	short biBitCount;                     // Глубина цвета в битах на пиксель.
	int biCompression;                    // Тип сжатия. Если компрессия не используется, то флаг имеет значенине 0.
	int biSizeImage;                      // Размер изображения в байтах. Если изображение не сжато, то здесь может быть записан 0.
	int biXPelsPerMeter;                  // Горизонтальное разрешение (в пикселях на метр).
	int biYPelsPerMeter;                  // Вертикальное разрешение (в пикселях на метр).
	int biClrUsed;                        // Количество используемых цветов кодовой таблицы. Если значение поля равно 0, то используется максимально возможное количество цветов, которые разрешены значением поля biBitCount.
	int biClrImportant;                   // Количество основных цветов. Определяет число цветов, необходимых для отображения изображения. Если значение поля равно 0, то используются все цвета.

}BITMAPINFOHEADER;
#pragma pack(pop)


Color **bitecolor;
char *buf;

void createbmp(BITMAPINFOHEADER bitmapInfoHeader, BITMAPFILEHEADER bitmapFileHeader, Color **bitecolor)
{
	FILE *newfile = fopen("tankresult.bmp", "wb");//открываем/создаем новый bmp файл
	//пишем в файл структуры
	fwrite(&bitmapFileHeader, sizeof(BITMAPFILEHEADER), 1, newfile);
	fwrite(&bitmapInfoHeader, sizeof(BITMAPINFOHEADER), 1, newfile);

	buf = (char*)malloc(sizeof(char) * 4); //мусор

	//пишем в файл RGB
	for (int i = 0; i < bitmapInfoHeader.biHeight; i++)
	{
		for (int j = 0; j < bitmapInfoHeader.biWidth; j++)
		{
			fwrite(&(bitecolor[i][j]), sizeof(bitecolor[i][j]), 1, newfile);
			if (bitmapInfoHeader.biBitCount == 32) fwrite(&buf, 1, 1, newfile);
		}
		if (bitmapInfoHeader.biBitCount == 24) fwrite(buf, sizeof(char), bitmapInfoHeader.biWidth % 4, newfile);
	}

	//закрываем файл
	fclose(newfile);
}

Color** readbmp(BITMAPINFOHEADER bitmapInfoHeader, BITMAPFILEHEADER bitmapFileHeader, FILE *file)
{
	//создаем массив структуры RGB
	bitecolor = (Color **)malloc(sizeof(Color*) * bitmapInfoHeader.biHeight);
	for (int j = 0; j < bitmapInfoHeader.biHeight; j++)
		bitecolor[j] = (Color *)malloc(sizeof(Color) * bitmapInfoHeader.biWidth);

	buf = (char*)malloc(sizeof(char) * 4);//Для хранения каждой строки выделяется кратное 4 количество байт. А в незначащих байтах хранится мусор.

	//читаем RGB
	for (int i = 0; i < bitmapInfoHeader.biHeight; i++)
	{
		for (int j = 0; j < bitmapInfoHeader.biWidth; j++)
		{
			fread(&(bitecolor[i][j]), sizeof(bitecolor[i][j]), 1, file);
			if (bitmapInfoHeader.biBitCount == 32) fread(&buf, 1, 1, file);
		}
		if (bitmapInfoHeader.biBitCount == 24) fread(buf, 1, bitmapInfoHeader.biWidth % 4, file);
	}

	return bitecolor;
}