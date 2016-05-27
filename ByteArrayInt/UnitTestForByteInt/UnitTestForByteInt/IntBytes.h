#include <stdio.h>
#include <vector>
#include <iostream>
using namespace std;

/*
* Issue #39: преобразование байтового массива в int[] и обратно с заданной точностью битов.
* Автор: Шпарута Софья
*/
class IntBytes {

private:

	//точность битов
	int accurancy;

	//Переводит вектор размера 8 из 0 и 1 в байтовое число
	//Вход: Вектор типа char
	//Выход: Число типа char, двоичное представление которого было на входе
	unsigned char bits_in_byte(std::vector<unsigned char> bits){
		unsigned char byte = 0;

		int k = 1;
		for(int j = bits.size() - 1; j >= 0; j--) {
			int b;
			bits[j] == '0' ? b = 0 : b = 1;			
			byte += (b * pow(2, k - 1));
			k++;
		}
		return byte;
	}

	//Переводит байтовое число в его двоичное представление
	//Вход: Число типа char
	//Выход: Двоичное представление в виде вектора
	std::vector<unsigned char> byte_in_bits(unsigned char byte){
		std::vector<unsigned char> bits(8);

		for(int j = 7; j >= 0; j--) {
			int a = byte % 2;
			a == 0 ? bits[j] = '0' : bits[j] = '1';
			byte /= 2;
		}
		return bits;
	}

	//Переводит вектор битов в вектор соответствующих им байтов
	//Вход: Вектор типа char
	//Выход: Вектор char, соответствующих им байтов
	std::vector<unsigned char> convert_bits_in_bytes(vector<unsigned char> bits){
		std::vector<unsigned char> bytes;
		std::vector<unsigned char> bits1(8);
		int k = 1;
		while(bits.size()%8!=0)
			bits.insert(bits.begin(), '0');

		for(int j = bits.size() / 8 - 1; j >= 0; j--) {
			for(int i = 0; i < 8; i++){
				bits1[i] = bits[i + j * 8];
			}
			bytes.insert(bytes.begin(), bits_in_byte(bits1));
		}

		return bytes;
	}

	//Переводит вектор битов в вектор соответствующих им байтов
	//Вход: Вектор типа char
	//Выход: Вектор char, соответствующих им битов в двоичном представлении
	std::vector<unsigned char> convert_bytes_in_bits(vector<unsigned char> bytes){
		std::vector<unsigned char> bits(8 * bytes.size());
		std::vector<unsigned char> bits1(8);
		for(int j = 0; j < bytes.size(); j++) {
			bits1 = byte_in_bits(bytes[j]);
			for(int i = 0; i < 8; i++){
				bits[i + j * 8] = bits1[i];
			}
		}

		return bits;
	}

public:

	//конструктор
	IntBytes(int acc){
		if(acc <= 32){ 
			accurancy = acc;
		}
		else accurancy = 0;
	}

	//Преобразует массив типа byte(char) в массив типа int
	//Вход: массив bytes типа char, int accuracy = точность битов, размер массива bytes (int)
	//Выход: массив first типа int
	std::vector<int> bits_array_in_int(vector<unsigned char> bytes) {
		std::vector<int> first;
		if (accurancy == 0) return first;

		bytes = convert_bytes_in_bits(bytes);

		int mod = bytes.size() % accurancy;
		int count = bytes.size() / accurancy;
		int i = 0;
		int k = 1;

		mod > 0 ? i = count : i = count - 1;

		for(int j = 0; j <= i; j++) {
			first.insert(first.end(), 0);
		}

		for(int j = bytes.size() - 1; j >= 0; j--) {
			int b;
			bytes[j] == '0' ? b = 0 : b = 1;
			first[i] += (b * pow(2, k - 1));
			if(k == accurancy){
				i--; 
				k = 1;
			}
			else 
				k++;
		}
		return first;
	}

	//Преобразует массив int в массив типа byte(char)
	//Вход: массив ints типа int, int accuracy = точность битов, размер массива size (int)
	//Выход: массив bytes типа char,
	std::vector<unsigned char> int_array_in_bits(std::vector<int> ints) {

		std::vector<unsigned char> bytes;
		if (accurancy == 0){
			return bytes;
		}

		for(int i = 0; i < accurancy * ints.size(); i++){
			bytes.insert(bytes.end(), '0');
		}

		for(int i = 0; i < ints.size(); i++) {
			for(int j = accurancy - 1; j >= 0; j--) {
				int a = ints[i] % 2;
				if(a != 0){ 
					bytes[j + (i * accurancy)] = '1';
				}
				ints[i] /= 2;
			}
		}

		return convert_bits_in_bytes(bytes);
	}
};

