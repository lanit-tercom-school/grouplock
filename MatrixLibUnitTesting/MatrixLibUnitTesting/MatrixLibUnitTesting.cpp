// MatrixLibUnitTesting.cpp: определ€ет точку входа дл€ консольного приложени€.
//

#include "stdafx.h"
#include "tnt.h"

using namespace TNT;

Array2D<int> arrayToMatrix(int *a, int row, int col) {
	Array2D<int> A(row, col, 0);
	for (int i = 0; i < row; i++)
		for (int j = 0; j < col; j++)
			A[i][j] = a[i * row + j];
	return A;
}

bool arraysEquals(Array2D<int> A, Array2D<int> B, int row, int col) {
	for (int i = 0; i < row; i++)
		for (int j = 0; j < col; j++)
			if (A[i][j] != B[i][j]) return false;
	return true;
}

void sumTest1() {
	int a[3][3] =
	{
		{ 5, 11, 23 },
		{ 7, 7, 7 },
		{ 53, 37, 71 },

	};

	int b[3][3] =
	{
		{ 9, 44, 107 },
		{ 16, 25, 40 },
		{ 205, 180, 231 },
	};

	int ans[3][3] =
	{
		{ 14, 55, 130 },
		{ 23, 32, 47 },
		{ 258, 217, 302 },
	};


	Array2D<int> A = arrayToMatrix(&a[0][0], 3, 3);
	Array2D<int> B = arrayToMatrix(&b[0][0], 3, 3);
	Array2D<int> C(3, 3, 0);

	C = A + B;

	assert(("SUMTEST1 - FAILED", arraysEquals(C, arrayToMatrix(&ans[0][0], 3, 3), 3, 3)));
	std::cout << "SUMTEST1 - SUCCESS\n";
}

void sumTest2(){
	int a[4][4] =
	{
		{ 14, 12, 8, 5 },
		{ 11, 11, 13, 9 },
		{ 8, 7, 4, 15 },
		{ 9, 3, 4, 3 },
	};

	int b[4][4] =
	{
		{ 0, 0, 0, 0 },
		{ 0, 0, 0, 0 },
		{ 0, 0, 0, 0 },
		{ 0, 0, 0, 0 },
	};

	int ans[4][4] =
	{
		{ 14, 12, 8, 5 },
		{ 11, 11, 13, 9 },
		{ 8, 7, 4, 15 },
		{ 9, 3, 4, 3 },
	};


	Array2D<int> A = arrayToMatrix(&a[0][0], 4, 4);
	Array2D<int> B = arrayToMatrix(&b[0][0], 4, 4);
	Array2D<int> C(4, 4, 0);

	C = A + B;

	assert(("SUMTEST2 - FAILED", arraysEquals(C, arrayToMatrix(&ans[0][0], 4, 4), 4, 4)));
	std::cout << "SUMTEST2 - SUCCESS\n";
}

void sumTest3() {
	int a[3][4] =
	{
		{ 18, 121, 3, 13 },
		{ 14, 101, 0, 1 },
		{ 0, 0, 1, 100 },
	};

	int b[3][4] =
	{
		{ 51, 0, 42, 11 },
		{ 1, 2, 9, 19 },
		{ 10, 99, 145, 153 },
	};

	int ans[3][4] =
	{
		{ 69, 121, 45, 24 },
		{ 15, 103, 9, 20 },
		{ 10, 99, 146, 253 },
	};

	Array2D<int> A = arrayToMatrix(&a[0][0], 3, 4);
	Array2D<int> B = arrayToMatrix(&b[0][0], 3, 4);
	Array2D<int> C(3, 4, 0);

	C = A + B;

	assert(("SUMTEST3 - FAILED", arraysEquals(C, arrayToMatrix(&ans[0][0], 3, 4), 3, 4)));
	std::cout << "SUMTEST3 - SUCCESS\n";
}

void sumTest4() {
	int a[6][6] =
	{
		{ 4, 6, 4, 2, 5, 4 },
		{ 5, 2, 5, 5, 4, 6 },
		{ 1, 4, 5, 3, 5, 2 },
		{ 5, 4, 2, 6, 5, 1 },
		{ 4, 6, 5, 2, 5, 4 },
		{ 6, 6, 6, 2, 6, 1 },
	};

	int b[6][6] =
	{
		{ 56, 13, 11, 15, 5, 87 },
		{ 4, 67, 15, 67, 3, 89 },
		{ 14, 12, 56, 12, 34, 5 },
		{ 5, 15, 78, 67, 5, 12 },
		{ 67, 67, 78, 3, 67, 67 },
		{ 67, 34, 54, 90, 54, 45 },
	};

	int ans[6][6] =
	{
		{ 60, 19, 15, 17, 10, 91 },
		{ 9, 69, 20, 72, 7, 95 },
		{ 15, 16, 61, 15, 39, 7 },
		{ 10, 19, 80, 73, 10, 13 },
		{ 71, 73, 83, 5, 72, 71 },
		{ 73, 40, 60, 92, 60, 46 },
	};

	Array2D<int> A = arrayToMatrix(&a[0][0], 6, 6);
	Array2D<int> B = arrayToMatrix(&b[0][0], 6, 6);
	Array2D<int> C(6, 6, 0);

	C = A + B;

	assert(("SUMTEST4 - FAILED", arraysEquals(C, arrayToMatrix(&ans[0][0], 6, 6), 6, 6)));
	std::cout << "SUMTEST4 - SUCCESS\n";
}

void multTest1() {
	int a[3][3] =
	{
		{ 5, 11, 23 },
		{ 7, 7, 7 },
		{ 53, 37, 71 },

	};

	int b[3][3] =
	{
		{ 9, 44, 107 },
		{ 16, 25, 40 },
		{ 205, 180, 231 },
	};

	int ans[3][3] =
	{
		{ 4936, 4635, 6288 },
		{ 1610, 1743, 2646 },
		{ 15624, 16037, 23552 },
	};


	Array2D<int> A = arrayToMatrix(&a[0][0], 3, 3);
	Array2D<int> B = arrayToMatrix(&b[0][0], 3, 3);
	Array2D<int> C(3, 3, 0);

	C = matmult(A, B);

	assert(("MULTTEST1 - FAILED", arraysEquals(C, arrayToMatrix(&ans[0][0], 3, 3), 3, 3)));
	std::cout << "MULTTEST1 - SUCCESS\n";
}

void multTest2() {
	int a[4][4] =
	{
		{ 14, 12, 8, 5 },
		{ 11, 11, 13, 9 },
		{ 8, 7, 4, 15 },
		{ 9, 3, 4, 3 },
	};

	int b[4][4] =
	{
		{ 0, 0, 0, 0 },
		{ 0, 0, 0, 0 },
		{ 0, 0, 0, 0 },
		{ 0, 0, 0, 0 },
	};

	int ans[4][4] =
	{
		{ 0, 0, 0, 0 },
		{ 0, 0, 0, 0 },
		{ 0, 0, 0, 0 },
		{ 0, 0, 0, 0 },
	};


	Array2D<int> A = arrayToMatrix(&a[0][0], 4, 4);
	Array2D<int> B = arrayToMatrix(&b[0][0], 4, 4);
	Array2D<int> C(4, 4, 0);

	C = matmult(A, B);

	assert(("MULTTEST2 - FAILED", arraysEquals(C, arrayToMatrix(&ans[0][0], 4, 4), 4, 4)));
	std::cout << "MULTTEST2 - SUCCESS\n";
}

void multTest3() {
	int a[3][4] =
	{
		{ 18, 121, 3, 13 },
		{ 14, 101, 0, 1 },
		{ 0, 0, 1, 100 },
	};

	int b[4][2] =
	{
		{ 11, 6 },
		{ 1, 15 },
		{ 43, 25 },
		{ 6, 12 },
	};

	int ans[3][2] =
	{
		{ 526, 2154 },
		{ 261, 1611 },
		{ 643, 1225 },
	};

	Array2D<int> A = arrayToMatrix(&a[0][0], 3, 4);
	Array2D<int> B = arrayToMatrix(&b[0][0], 4, 2);
	Array2D<int> C(3, 2, 0);

	C = matmult(A, B);

	for (int i = 0; i < 3; i++)
		for (int j = 0; j < 2; j++)
			std::cout << C[i][j] << "\n";

	assert(("MULTTEST3 - FAILED", arraysEquals(C, arrayToMatrix(&ans[0][0], 3, 2), 3, 2)));
	std::cout << "MULTTEST3 - SUCCESS\n";
}

void multTest4() {
	int a[6][6] =
	{
		{ 4, 6, 4, 2, 5, 4 },
		{ 5, 2, 5, 5, 4, 6 },
		{ 1, 4, 5, 3, 5, 2 },
		{ 5, 4, 2, 6, 5, 1 },
		{ 4, 6, 5, 2, 5, 4 },
		{ 6, 6, 6, 2, 6, 1 },
	};

	int b[6][6] =
	{
		{ 1, 0, 0, 0, 0, 0 },
		{ 0, 1, 0, 0, 0, 0 },
		{ 0, 0, 1, 0, 0, 0 },
		{ 0, 0, 0, 1, 0, 0 },
		{ 0, 0, 0, 0, 1, 0 },
		{ 0, 0, 0, 0, 0, 1 },
	};

	int ans[6][6] =
	{
		{ 4, 6, 4, 2, 5, 4 },
		{ 5, 2, 5, 5, 4, 6 },
		{ 1, 4, 5, 3, 5, 2 },
		{ 5, 4, 2, 6, 5, 1 },
		{ 4, 6, 5, 2, 5, 4 },
		{ 6, 6, 6, 2, 6, 1 },
	};

	Array2D<int> A = arrayToMatrix(&a[0][0], 6, 6);
	Array2D<int> B = arrayToMatrix(&b[0][0], 6, 6);
	Array2D<int> C(6, 6, 0);

	C = matmult(A, B);

	assert(("MULTTEST4 - FAILED", arraysEquals(C, arrayToMatrix(&ans[0][0], 6, 6), 6, 6)));
	std::cout << "MULTTEST4 - SUCCESS\n";
}

int main()
{
	sumTest1();
	sumTest2();
	sumTest3();
	sumTest4();
	multTest1();
	multTest2();
	//multTest3(); ------------------------------------------------------------- ?
	multTest4();
	//ќбратные матрицы --------------------------------------------------------- ?
	//Ќахождение по модулю простого числа -------------------------------------- ?
	//¬з€тие матрицы по модулю матрицы из простых чисел ------------------------ ?
	//и т.д. суперпозиции по модулю простого числа и матрице из простых чисел -- ?
	
	std::getchar();

    return 0;
}

