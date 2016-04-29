#pragma once
#include "Poly.h"
#include "PrimeNum.h"
using namespace PrimeNum;
using namespace std;
// класс для хранения частей секрета
class parts {
public:
	vector<Array2D<int>> X; // точки, в которых мы ищем значение полинома
	vector<Array2D<int>> K_i; // сами значения в точках Х
	int deg, p, kolParts; // степень полинома, простое число, количество частей, необходимое для восстановления секрета
	parts(vector<Array2D<int>> xx, vector<Array2D<int>> k, int n, int pp, int kolP) {
		deg = n;
		p = pp;
		kolParts = kolP;
		for (int i = 0; i < kolParts; i++)
			X.push_back(xx[i]), K_i.push_back(k[i]);
	};
};
// возведение матрицы в степень
Array2D<int> power(Array2D<int>& v, int deg, int dim, int p) {
	Array2D<int> A = v;

	if (deg == 0) {
		for (int i = 0; i < dim; ++i) {
			for (int j = 0; j < dim; ++j) {
				if (i == j) A[i][j] = 1; else A[i][j] = 0;
			}
		}
	}
	else
	{
		for (int i = 1; i < deg; ++i) {
			A = matmult(A, A) % p;
		}
	}

	return A;
}
// вычисление значения полинома в точке
Array2D<int> getVal(Array2D<int>& v, Poly& pol, int p) {
	Array2D<int> A(pol.dim, pol.dim);
	for (int i = 0; i < pol.dim; ++i) {
		for (int j = 0; j < pol.dim; ++j) A[i][j] = 0;
	}

	for (int i = 0; i <= pol.deg; ++i) {
		Array2D<int> B = power(v, pol.deg - i, pol.dim, p);

		Array2D<int> P = pol.coefPtr[i];
		A = A + (matmult(P, B));
	}

	A = A % p;

	return A;
}
// вычисление разрности необходимого простого числа
int dig(int max) {
	int d = 0;
	while (max > 0) {
		++d;
		max /= 10;
	}
	return d;
}

// генерация рандомного диагонального Х
void f(int dimM, int p, Array2D<int> b, Array2D<int> a) {
	for (int i = 0; i < dimM; ++i) {
		b[i][i] = (a[i][i] + 1) % (p - 1) + 1;
	}

}
// метод для получения частей секрета
parts getPartsK(int degPol, Array2D<int>A, int dimA, int kolParts) {
	int maxP = A[0][0];
	for (int i = 0; i < dimA; ++i) {
		for (int j = 0; j < dimA; ++j) {
			if (A[i][j] > maxP)
				maxP = A[i][j];
		}
	}
	// выбор максимального числа секрета, для выбора простого числа
	int max = (maxP > dimA ? max = maxP : dimA);
	// выбор простого числа, используется библиотека PrimeNum.h
	int p = choice_PrimeNum(max, dig(max) + 1);

	// построение полинома необходимой степени
	vector<Array2D<int>> v;
	getP(degPol, v, A, dimA, p);
	Poly pp(v, degPol, dimA);

	int n = pp.dim;
	Array2D<int> b(n, n, 0);
	vector<Array2D<int>> X;
	int y = 0;

	// Генерация Х --
	for (int i = 0; i < n; ++i) {
		//for (int j = 0; j < n; ++j) 
		b[i][i] = rand() % (p - 1) + 1;
	}
	X.push_back(b);
	for (int i = 1; i < kolParts; ++i)
	{
		Array2D<int> B(dimA, dimA, 0);
		f(dimA, p, B, b);
		X.push_back(B);
		b = B;
	}
	// --
	// Вычисление значений в точках Х
	vector<Array2D<int>> K;
	int xx = X.size();
	for (auto& i : X) {
		Array2D<int> S;
		S = i.copy();
		Array2D<int> B = getVal(i, pp, p);
		K.push_back(B);
		i = S;
	}

	parts P(X, K, degPol+1, p, kolParts);
	return P;
}
// преобразование отрицательных дробей к виду: -числитель / знаменатель
void fFraction(Array2D<Fraction> l, int dim) {
	for (int i1 = 0; i1 < dim; ++i1) {
		for (int j1 = 0; j1 < dim; ++j1) {
			if (l[i1][j1].z < 0) l[i1][j1].c = -l[i1][j1].c, l[i1][j1].z = -l[i1][j1].z;
		}
	}
}

// если число < 0 то добавляем p, чтобы все числа были больше 0
void plusP(Array2D<Fraction> l, int dim, int p) {
	for (int k1 = 0; k1 < dim; ++k1) {
		for (int k2 = 0; k2 < dim; ++k2)
		{
			if (l[k1][k2].c < 0) l[k1][k2].c += p;
		}
	}
}
// функция для восстановления секрета
Array2D<Fraction> makeSecret(vector<Array2D<int>> Kin, vector<Array2D<int>> Xin, int k, int p, int dim) {
	// перевод ключей из int в Fraction, для избежания погрешностей при вычислении
	vector<Array2D<Fraction>> X;
	for (auto& k : Xin) {
		Array2D<Fraction> F(dim, dim);
		for (int i = 0; i < dim; ++i) {
			for (int j = 0; j < dim; ++j) {
				F[i][j].c = k[i][j];
				F[i][j].z = 1;
			}
		}
		X.push_back(F);
	}
	vector<Array2D<Fraction>> K;
	for (auto& k : Kin) {
		Array2D<Fraction> F(dim, dim);
		for (int i = 0; i < dim; ++i) {
			for (int j = 0; j < dim; ++j) {
				F[i][j].c = k[i][j];
				F[i][j].z = 1;
			}
		}
		K.push_back(F);
	}
	
	Array2D<Fraction> M(dim, dim);
	// инициализация матрицы M, которая в дальнейшем и будет содержать восстановленный секрет
	for (int i = 0; i < dim; ++i) {
		for (int j = 0; j < dim; ++j) M[i][j] = 0;

	}
	// инициализация вспомогательных матриц
	for (int i = 0; i < k; ++i) {
		Array2D<Fraction> l(dim, dim);
		for (int k1 = 0; k1 < dim; ++k1) {
			for (int k2 = 0; k2 < dim; ++k2) {
				if (k1 == k2) l[k1][k2] = 1; else l[k1][k2] = 0;
			}
		}
		Array2D<Fraction> ras(dim, dim);
		for (int j = 0; j < k; ++j)
		{
			// считаем l по формуле: произведение всех -x[j]/(x[i]-x[j]), где i!=j
			if (i != j) {
				ras = X[i] - X[j];
				Array2D<Fraction> C(dim, dim);
				C = inverse(ras);
				fFraction(l, dim);
				fFraction(C, dim);
				Array2D<Fraction> D = matmult(X[j], C);
				D = matmult(l, D);
				l = Fraction(-1, 1) * D;
				fFraction(l, dim);
				l = l % p;
			
				for (int k1 = 0; k1 < dim; ++k1) {
					for (int k2 = 0; k2 < dim; ++k2)
					{
						if (l[k1][k2].c < 0) l[k1][k2].c += p;
					}
				}
			}
		}
		fFraction(l, dim);
		l = l % p;
		plusP(l, dim, p);
	
		M = M + (K[i] * l);
		fFraction(M, dim);
		for (int i = 0; i < dim; ++i) {
			for (int j = 0; j < dim; ++j) {
				M[i][j].c = M[i][j].c % p;
			}
		}
		plusP(M, dim, p);
	}
	fFraction(M, dim);
	for (int i = 0; i < dim; ++i) {
		for (int j = 0; j < dim; ++j) {
			M[i][j].c = M[i][j].c % p;
		}
	}
	plusP(M, dim, p);
	return M;
}