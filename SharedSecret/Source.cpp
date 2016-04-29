#include <iostream>
#include <vector>

#include "Debug\fraction.h"
#include "partsSecret.h"

using namespace std;
using namespace TNT;

int main() {
	int dimA = 3;
	Array2D<int> A(dimA, dimA);
	
	A[0][0] = 19;
	A[1][0] = 2;
	A[0][1] = 3;
	A[1][1] = 57;
	A[2][0] = 0;
	A[0][2] = 1;
	A[2][2] = 999;
	A[1][2] = 3;
	A[2][1] = 4;
	parts p = getPartsK( 2, A, dimA, 4); //минимальное количество ключей - 1, секрет, размерность секрета, количество получаемых ключей
	cout << "Secret's parts: " << endl;
	for (auto& i : p.K_i) {
		for (int k = 0; k < dimA; ++k) {
			for (int kk = 0; kk < dimA; ++kk) cout << i[k][kk] << ' ';
			cout << '\n';
		}
	}
	
	cout << "secret: " << endl;
	Array2D<Fraction> B(dimA, dimA);
   B = makeSecret(p.K_i, p.X, p.deg , p.p, dimA);
	for (int i = 0; i < dimA; ++i) {
	for (int j = 0; j < dimA; ++j) cout << B[i][j].c  << ' ' ;
		cout << '\n';
	}
	system("pause");
	return 0;
}