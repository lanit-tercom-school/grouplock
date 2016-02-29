#include <stdio.h>
#include <iostream>
using namespace std;

int power(int X, int p) //возведение в степень
{
	int Pow = 1;
	for(int i = 1; i <= p; i++)
	{
		Pow *= X;
	}

	return Pow; 
}

int CountBits(int X) // считает кол-во разрядов числа в двоичном представлении
{
	int k = 0;
	while(X > 0)
	{
		X = X / 2;
		k++;
	}

	return k;
}

char* ReverseChar(char* A, int size) //представляет массив Charов в обратном порядке
{
	for(int i = 0; i < size / 2; i++)
	{
		char x = A[i];
		A[i] = A[size - 1 - i];
		A[size - 1 - i] = x;
	}
	return A;
}

int* ReverseInt(int* A, int size) //представляет массив Intов в обратном порядке
{
	for(int i = 0; i < size/2; i++)
	{
		char x = A[i];
		A[i] = A[size - 1 - i];
		A[size - 1 - i] = x;
	}
	return A;
}

int* ByteArrayInInt(char* Bytes, int accuracy, int size)
{
	Bytes = ReverseChar(Bytes, size);

	int Mod = size % accuracy;
	int Count = size / accuracy;

	int* first;
	if(Mod > 0)
		first = new int [Count + 1];
	else
		first = new int[Count];

	for(int j = 0; j <= Count; j++)
		first[j] = 0;

	for(int j = 0; j < Count; j++)
		for(int i = 0; i < accuracy; i++)
		{
			int b;
			if(Bytes[i + (j * accuracy)]=='0')
				b = 0;
			else b = 1;

			first[j] += (b * power(2, i)); 
		}

		if(Mod > 0)
		{
			for(int i = 0; i < Mod; i++)
			{
				int b;
				if(Bytes[i + (Count * accuracy)]=='0')
					b = 0;
				else b = 1;

				first[Count] += (b * power(2, i)); 
			}
		}
		
		if(Mod == 0)
			first = ReverseInt(first, Count);
		else 
			first = ReverseInt(first, Count + 1);
		
		return first;
}

char* IntArrayInBytes(int* Ints, int accurancy, int size)
{
	int Size = accurancy * size;
	char* bytes = new char[accurancy * size];
	for(int i = 0; i < size; i++)
	{
		if(CountBits(Ints[i]) > accurancy) return 0;
		for(int j = accurancy - 1; j >= 0; j--)
		{
			int a = Ints[i] % 2;
			if(a == 0)
				bytes[j + (i * accurancy)] = '0';
			else			
                bytes[j + (i * accurancy)] = '1';
			
			Ints[i] = Ints[i] / 2;
		}
	}

	return bytes;
}
