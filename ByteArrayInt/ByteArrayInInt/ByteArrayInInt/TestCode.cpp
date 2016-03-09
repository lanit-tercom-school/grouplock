#include <iostream>
#include <stdio.h>
#include "IntBytes.h"
using namespace std;

int main()
{

int i = 0;
int acc;

cout << "Please, enter the key\n" ;
char* S1 = new char[i];

do
{
	S1[i] = getchar();
	if(S1[i] != ' ')
		i++;
} while (S1[i-1] != '\n');

/*cout << "Please, enter the array size\n" ;
int size = 0;
int k;
cin >> size;

/*cout << "Please, enter the key\n" ; //¬вод через enter
int* S = new int[size];

for(k = 0; k < size; k++)
{
cin >> S[k];
}*/

//for(int j = 0; j < i - 1; j++)
//{
//cout<<S1[j];
//}

cout <<"\nPlease, enter the accurancy\n";
cin >> acc;

//char* I = IntArrayInBytes(S, acc, size);
//if(I == 0) 
//	{cout <<"\nData is incorrect\n";
//}

//else

IntBytes objMessage(acc);
int Nsize = (i - 1)/acc;
if((i - 1) % acc > 0) Nsize++;
int* I = new int[Nsize];
I = objMessage.byte_array_in_int(S1, i - 1);

for(int j = 0; j < Nsize; j++)
{
	cout<<I[j]<<" ";
}

system("pause"); 
return 0;
}