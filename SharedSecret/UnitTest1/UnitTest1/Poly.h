/*
Сласс Poly содержит два поля: массив с коэффициентами и степень многочлена.
Определены две функции: getCoef - создает матрицу заполненую рандомными числами по модулю р, getP - для заполнения поля массива коэфициентов
в классе Poly
*/
#pragma once
#include <vector>
#include "fraction.h"
#include "tnt.h"

using namespace std;
using namespace TNT;

class Poly {
public:	
	vector<Array2D<int>> coefPtr; // вектор с коэф-ми полинома
		int deg; // степень полинома
		int dim; // размерность матрицы- секрета
		Poly(vector<Array2D<int>> coef, int n, int dimM) {
			deg = n;
			dim = dimM;
			for (int i = 0; i <= n; i++)
				coefPtr.push_back(coef[i]);
		};
		~Poly() {};

};
// генерация коэфициента для полинома 
void getCoef(int dimM, int p, Array2D<int> coefPtr) {
	for (int i = 0; i < dimM; ++i) {
		for (int j = 0; j < dimM; ++j)
			//coefPtr[i][j] = Fraction(rand() % (p - 1) + 1, rand() % (p - 1) + 1);
			coefPtr[i][j] = rand() % (p - 1) + 1;
	}

}
// генерация самого полинома
void getP(int n, vector<Array2D<int>>& v, Array2D<int> A, int dimM, int p)
{
	for (int i = 0; i < n; ++i)
	{
		Array2D<int> B(dimM, dimM);
		getCoef(dimM, p, B);
		v.push_back(B);
	}
	v.push_back(A);
}

