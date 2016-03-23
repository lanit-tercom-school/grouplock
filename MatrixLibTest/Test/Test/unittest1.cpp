#include "stdafx.h"
#include "CppUnitTest.h"
#include "tnt.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;
using namespace TNT;

namespace Test
{		
	TEST_CLASS(UnitTest1)
	{
	public:
		
		TEST_METHOD(SumTest1)
		{
			int a[3][3]
			{
				{ 5, 11, 23 },
				{ 7, 7, 7 },
				{ 53, 37, 71 }
			};

			int b[3][3]
			{
				{ 9, 44, 107 },
				{ 16, 25, 40 },
				{ 205, 180, 231 }
			};

			int c[3][3]
			{
				{ 14, 55, 130 },
				{ 23, 32, 47 },
				{ 258, 217, 302 }
			};

			Array2D<int> A(3, 3, *a);
			Array2D<int> B(3, 3, *b);
			Array2D<int> C(3, 3, *c);

			Assert::AreEqual(A + B == C, true);
		}

		TEST_METHOD(SumTest2) 
		{
			int a[4][4]
			{
				{ 14, 12, 8, 5 },
				{ 11, 11, 13, 9 },
				{ 8, 7, 4, 15 },
				{ 9, 3, 4, 3 }
			};

			int b[4][4]
			{
				{ 0, 0, 0, 0 },
				{ 0, 0, 0, 0 },
				{ 0, 0, 0, 0 },
				{ 0, 0, 0, 0 }
			};

			int c[4][4]
			{ 
				{ 14, 12, 8, 5 },
				{ 11, 11, 13, 9 },
				{ 8, 7, 4, 15 },
				{ 9, 3, 4, 3 }
			};

			Array2D<int> A(4, 4, *a);
			Array2D<int> B(4, 4, *b);
			Array2D<int> C(4, 4, *c);

			Assert::AreEqual(A + B == C, true);
		}

		TEST_METHOD(SumTest3)
		{
			int a[3][4]
			{
				{ 18, 121, 3, 13 },
				{ 14, 101, 0, 1 },
				{ 0, 0, 1, 100 }
			};

			int b[3][4]
			{
				{ 51, 0, 42, 11 },
				{ 1, 2, 9, 19 },
				{ 10, 99, 145, 153 }
			};

			int c[3][4]
			{
				{ 69, 121, 45, 24 },
				{ 15, 103, 9, 20 },
				{ 10, 99, 146, 253 }
			};

			Array2D<int> A(3, 4, *a);
			Array2D<int> B(3, 4, *b);
			Array2D<int> C(3, 4, *c);

			Assert::AreEqual(A + B == C, true);
		}

		TEST_METHOD(SumTest4)
		{
			int a[6][6]
			{
				{ 4, 6, 4, 2, 5, 4 },
				{ 5, 2, 5, 5, 4, 6 },
				{ 1, 4, 5, 3, 5, 2 },
				{ 5, 4, 2, 6, 5, 1 },
				{ 4, 6, 5, 2, 5, 4 },
				{ 6, 6, 6, 2, 6, 1 }
			};

			int b[6][6]
			{
				{ 56, 13, 11, 15, 5, 87 },
				{ 4, 67, 15, 67, 3, 89 },
				{ 14, 12, 56, 12, 34, 5 },
				{ 5, 15, 78, 67, 5, 12 },
				{ 67, 67, 78, 3, 67, 67 },
				{ 67, 34, 54, 90, 54, 45 }
			};

			int c[6][6]
			{
				{ 60, 19, 15, 17, 10, 91 },
				{ 9, 69, 20, 72, 7, 95 },
				{ 15, 16, 61, 15, 39, 7 },
				{ 10, 19, 80, 73, 10, 13 },
				{ 71, 73, 83, 5, 72, 71 },
				{ 73, 40, 60, 92, 60, 46 }
			};

			Array2D<int> A(6, 6, *a);
			Array2D<int> B(6, 6, *b);
			Array2D<int> C(6, 6, *c);

			Assert::AreEqual(A + B == C, true);
		}

		TEST_METHOD(ScalarMultTest1)
		{
			int a[3][3]
			{
				{ 0, 9, 22 },
				{ 4, 2, 5 },
				{ 23, 28, 11 }
			};

			int p = 15;

			int c[3][3]
			{
				{ 0, 135, 330 },
				{ 60, 30, 75 },
				{ 345, 420, 165 }
			};

			Array2D<int> A(3, 3, *a);
			Array2D<int> C(3, 3, *c);

			Assert::AreEqual(A * p == C, true);
			Assert::AreEqual(p * A == C, true);
		}

		TEST_METHOD(ScalarMultTest2)
		{
			int a[3][3]
			{
				{ 9, 44, 107 },
				{ 16, 25, 40 },
				{ 205, 180, 231 }
			};

			int p = 0;

			int c[3][3]
			{
				{ 0, 0, 0 },
				{ 0, 0, 0 },
				{ 0, 0, 0 }
			};

			Array2D<int> A(3, 3, *a);
			Array2D<int> C(3, 3, *c);

			Assert::AreEqual(A * p == C, true);
			Assert::AreEqual(p * A == C, true);
		}

		TEST_METHOD(ScalarMultTest3)
		{
			double a[4][4]
			{
				{ 14, 12, 8, 5 },
				{ 11, 11, 13, 9 },
				{ 8, 7, 4, 15 },
				{ 9, 3, 4, 3 }
			};

			double p = 0.5;

			double c[4][4]
			{
				{ 7, 6, 4, 2.5 },
				{ 5.5, 5.5, 6.5, 4.5 },
				{ 4, 3.5, 2, 7.5 },
				{ 4.5, 1.5, 2, 1.5 }
			};

			Array2D<double> A(4, 4, *a);
			Array2D<double> C(4, 4, *c);

			Assert::AreEqual(A * p == C, true);
			Assert::AreEqual(p * A == C, true);
		}

		TEST_METHOD(ScalarMultTest4)
		{
			int a[3][4]
			{
				{ 18, 121, 3, 13 },
				{ 14, 101, 0, 1 },
				{ 0, 0, 1, 100 }
			};

			int p = 64;

			int c[3][4]
			{
				{ 1152, 7744, 192, 832 },
				{ 896, 6464, 0, 64 },
				{ 0, 0, 64, 6400 }
			};

			Array2D<int> A(3, 3, *a);
			Array2D<int> C(3, 3, *c);

			Assert::AreEqual(A * p == C, true);
			Assert::AreEqual(p * A == C, true);
		}

		TEST_METHOD(MultTest1)
		{
			int a[3][3]
			{
				{ 5, 11, 23 },
				{ 7, 7, 7 },
				{ 53, 37, 71 }
			};

			int b[3][3]
			{
				{ 9, 44, 107 },
				{ 16, 25, 40 },
				{ 205, 180, 231 }
			};

			int c[3][3]
			{
				{ 4936, 4635, 6288 },
				{ 1610, 1743, 2646 },
				{ 15624, 16037, 23552 }
			};

			Array2D<int> A(3, 3, *a);
			Array2D<int> B(3, 3, *b);
			Array2D<int> C(3, 3, *c);

			Assert::AreEqual(matmult(A, B) == C, true);
		}

		TEST_METHOD(MultTest2)
		{
			int a[4][4]
			{
				{ 14, 12, 8, 5 },
				{ 11, 11, 13, 9 },
				{ 8, 7, 4, 15 },
				{ 9, 3, 4, 3 }
			};

			int b[4][4]
			{
				{ 0, 0, 0, 0 },
				{ 0, 0, 0, 0 },
				{ 0, 0, 0, 0 },
				{ 0, 0, 0, 0 }
			};

			int c[4][4]
			{
				{ 0, 0, 0, 0 },
				{ 0, 0, 0, 0 },
				{ 0, 0, 0, 0 },
				{ 0, 0, 0, 0 }
			};

			Array2D<int> A(4, 4, *a);
			Array2D<int> B(4, 4, *b);
			Array2D<int> C(4, 4, *c);

			Assert::AreEqual(matmult(A, B) == C, true);
		}

		TEST_METHOD(MultTest3)
		{
			int a[3][4]
			{
				{ 18, 121, 3, 13 },
				{ 14, 101, 0, 1 },
				{ 0, 0, 1, 100 }
			};

			int b[4][2]
			{
				{ 11, 6 },
				{ 1, 15 },
				{ 43, 25 },
				{ 6, 12 }
			};

			int c[3][2]
			{
				{ 526, 2154 },
				{ 261, 1611 },
				{ 643, 1225 }
			};

			Array2D<int> A(3, 4, *a);
			Array2D<int> B(4, 2, *b);
			Array2D<int> C(3, 2, *c);

			Assert::AreEqual(matmult(A, B) == C, true);
		}

		TEST_METHOD(MultTest4)
		{
			int a[6][6]
			{
				{ 4, 6, 4, 2, 5, 4 },
				{ 5, 2, 5, 5, 4, 6 },
				{ 1, 4, 5, 3, 5, 2 },
				{ 5, 4, 2, 6, 5, 1 },
				{ 4, 6, 5, 2, 5, 4 },
				{ 6, 6, 6, 2, 6, 1 }
			};

			int b[6][6]
			{
				{ 1, 0, 0, 0, 0, 0 },
				{ 0, 1, 0, 0, 0, 0 },
				{ 0, 0, 1, 0, 0, 0 },
				{ 0, 0, 0, 1, 0, 0 },
				{ 0, 0, 0, 0, 1, 0 },
				{ 0, 0, 0, 0, 0, 1 }
			};

			int c[6][6]
			{
				{ 4, 6, 4, 2, 5, 4 },
				{ 5, 2, 5, 5, 4, 6 },
				{ 1, 4, 5, 3, 5, 2 },
				{ 5, 4, 2, 6, 5, 1 },
				{ 4, 6, 5, 2, 5, 4 },
				{ 6, 6, 6, 2, 6, 1 }
			};

			Array2D<int> A(6, 6, *a);
			Array2D<int> B(6, 6, *b);
			Array2D<int> C(6, 6, *c);

			Assert::AreEqual(matmult(A, B) == C, true);
		}

		TEST_METHOD(ModuleNumTest1) 
		{
			int a[6][6]
			{
				{ 56, 13, 11, 15, 5, 87 },
				{ 4, 67, 15, 67, 3, 89 },
				{ 14, 12, 56, 12, 34, 5 },
				{ 5, 15, 78, 67, 5, 12 },
				{ 67, 67, 78, 3, 67, 67 },
				{ 67, 34, 54, 90, 54, 45 }
			};

			int p = 7;

			int c[6][6]
			{
				{ 0, 6, 4, 1, 5, 3 },
				{ 4, 4, 1, 4, 3, 5 },
				{ 0, 5, 0, 5, 6, 5 },
				{ 5, 1, 1, 4, 5, 5 },
				{ 4, 4, 1, 3, 4, 4 },
				{ 4, 6, 5, 6, 5, 3 }
			};

			Array2D<int> A(6, 6, *a);
			Array2D<int> C(6, 6, *c);

			Assert::AreEqual(A % p == C, true);
		}

		TEST_METHOD(ModuleNumTest2)
		{
			int a[4][4]
			{
				{ 393, 36, 24, 15 },
				{ 66, 108, 78, 54 },
				{ 192, 168, 1080, 360 },
				{ 36, 12, 16, 764 }
			};

			int p = 23;

			int c[4][4]
			{
				{ 2, 13, 1, 15 },
				{ 20, 16, 9, 8 },
				{ 8, 7, 22, 15 },
				{ 13, 12, 16, 5 }
			};

			Array2D<int> A(4, 4, *a);
			Array2D<int> C(4, 4, *c);

			Assert::AreEqual(A % p == C, true);
		}

		TEST_METHOD(ModuleNumTest3)
		{
			int a[3][2]
			{
				{ 526, 2154 },
				{ 261, 1611 },
				{ 643, 1225 }
			};

			int p = 31;

			int c[3][2]
			{
				{ 30, 15 },
				{ 13, 30 },
				{ 23, 16 }
			};

			Array2D<int> A(3, 2, *a);
			Array2D<int> C(3, 2, *c);

			Assert::AreEqual(A % p == C, true);
		}

		TEST_METHOD(ModuleNumTest4)
		{
			int a[6][6]
			{
				{ 917, 1003, 1120, 1019, 735, 1441 },
				{ 1053, 806, 1391, 1156, 818, 1236 },
				{ 626, 789, 1083, 739, 645, 929 },
				{ 756, 816, 1139, 874, 524, 1253 },
				{ 931, 1015, 1176, 1031, 769, 1446 },
				{ 923, 1018, 1170, 806, 718, 1557 }
			};

			int p = 37;

			int c[6][6]
			{
				{ 29, 4, 10, 20, 32, 35 },
				{ 17, 29, 22, 9, 4, 15 },
				{ 34, 12, 10, 36, 16, 4 },
				{ 16, 2, 29, 23, 6, 32 },
				{ 6, 16, 29, 32, 29, 3 },
				{ 35, 19, 23, 29, 15, 3 }
			};

			Array2D<int> A(6, 6, *a);
			Array2D<int> C(6, 6, *c);

			Assert::AreEqual(A % p == C, true);
		}

		TEST_METHOD(ModuleMatTest1)
		{
			int a[3][3]
			{
				{ 369, 450, 239 },
				{ 154, 185, 108 },
				{ 1266, 1800, 1531 }
			};

			int b[3][3]
			{
				{ 5, 11, 23 },
				{ 7, 5, 13 },
				{ 41, 31, 53 }
			};

			int c[3][3]
			{
				{ 4, 10, 9 },
				{ 0, 0, 4 },
				{ 36, 2, 47 }
			};

			Array2D<int> A(3, 3, *a);
			Array2D<int> B(3, 3, *b);
			Array2D<int> C(3, 3, *c);

			Assert::AreEqual(A % B == C, true);
		}

		TEST_METHOD(ModuleMatTest2)
		{
			int a[4][4]
			{
				{ 393, 36, 24, 15 },
				{ 66, 108, 78, 54 },
				{ 192, 168, 1080, 360 },
				{ 36, 12, 16, 764 }
			};

			int b[4][4]
			{
				{ 137, 13, 11, 7 },
				{ 17, 19, 23, 29 },
				{ 11, 31, 47, 31 },
				{ 17, 5, 7, 193 }
			};

			int c[4][4]
			{
				{ 119, 10, 2, 1 },
				{ 15, 13, 9, 25 },
				{ 5, 13, 46, 19 },
				{ 2, 2, 2, 185 }
			};

			Array2D<int> A(4, 4, *a);
			Array2D<int> B(4, 4, *b);
			Array2D<int> C(4, 4, *c);

			Assert::AreEqual(A % B == C, true);
		}

		TEST_METHOD(ModuleMatTest3)
		{
			int a[3][2]
			{
				{ 526, 2154 },
				{ 261, 1611 },
				{ 643, 1225 }
			};
			
			int b[3][2]
			{
				{ 13, 29 },
				{ 59, 11 },
				{ 37, 43 }
			};

			int c[3][2]
			{
				{ 6, 8 },
				{ 25, 5 },
				{ 14, 21 }
			};

			Array2D<int> A(3, 2, *a);
			Array2D<int> B(3, 2, *b);
			Array2D<int> C(3, 2, *c);

			Assert::AreEqual(A % B == C, true);
		}

		TEST_METHOD(ModuleMatTest4)
		{
			int a[6][6]
			{
				{ 917, 1003, 1120, 1019, 735, 1441 },
				{ 1053, 806, 1391, 1156, 818, 1236 },
				{ 626, 789, 1083, 739, 645, 929 },
				{ 756, 816, 1139, 874, 524, 1253 },
				{ 931, 1015, 1176, 1031, 769, 1446 },
				{ 923, 1018, 1170, 806, 718, 1557 }
			};

			int b[6][6]
			{
				{ 59, 17, 13, 29, 7, 89 },
				{ 11, 79, 29, 79, 17, 97 },
				{ 17, 17, 67, 23, 43, 13 },
				{ 19, 19, 97, 83, 17, 23 },
				{ 101, 103, 103, 7, 79, 73 },
				{ 107, 47, 59, 113, 61, 47 }
			};

			int c[6][6]
			{
				{ 32, 0, 2, 4, 0, 17 },
				{ 8, 16, 28, 50, 2, 72 },
				{ 14, 7, 11, 3, 0, 6 },
				{ 15, 18, 72, 44, 14, 11 },
				{ 22, 88, 43, 2, 58, 59 },
				{ 67, 31, 49, 15, 47, 6 }
			};

			Array2D<int> A(6, 6, *a);
			Array2D<int> B(6, 6, *b);
			Array2D<int> C(6, 6, *c);

			Assert::AreEqual(A % B == C, true);
		}

		TEST_METHOD(DetTest1) 
		{
			int a[3][3]
			{
				{ 5, 11, 23 },
				{ 7, 7, 7 },
				{ 53, 37, 71 }
			};

			int d = -2772;

			Array2D<int> A(3, 3, *a);

			Assert::AreEqual(det(A) == d, true);
		}

		TEST_METHOD(DetTest2)
		{
			int a[4][4]
			{
				{ 1, 0, 0, 0 },
				{ 0, 1, 0, 0 },
				{ 0, 0, 1, 0 },
				{ 0, 0, 0, 1 }
			};

			int d = 1;

			Array2D<int> A(4, 4, *a);

			Assert::AreEqual(det(A) == d, true);
		}

		TEST_METHOD(DetTest3)
		{
			double a[3][3]
			{
				{ 7, 9, 5.65 },
				{ 3.14, 2, 0 },
				{ 0, 23, 17 }
			};

			double d = 165.623;

			Array2D<double> A(3, 3, *a);

			Assert::AreEqual(abs(det(A) - d) < 0.001, true);
		}

		TEST_METHOD(DetTest4)
		{
			int a[6][6]
			{
				{ 0, 0, 0, 0, 0, 0 },
				{ 0, 0, 0, 0, 0, 0 },
				{ 0, 0, 0, 0, 0, 0 },
				{ 0, 0, 0, 0, 0, 0 },
				{ 0, 0, 0, 0, 0, 0 },
				{ 0, 0, 0, 0, 0, 0 }
			};

			int d = 0;

			Array2D<int> A(6, 6, *a);

			Assert::AreEqual(det(A) == d, true);
		}

		TEST_METHOD(MinorTest1)
		{
			int a[3][3]
			{
				{ 0, 9, 22 },
				{ 4, 2, 5 },
				{ 23, 28, 11 }
			};

			int row = 2;
			int col = 1;

			int c[2][2]
			{
				{ 0, 22 },
				{ 4, 5 }
			};

			Array2D<int> A(3, 3, *a);
			Array2D<int> C(2, 2, *c);

			Assert::AreEqual(minor(A, row, col) == C, true);
		}

		TEST_METHOD(MinorTest2)
		{
			int a[2][2]
			{
				{ 1, 2 },
				{ 3, 4 }
			};

			int row = 0;
			int col = 0;

			int c[1][1] { 4 };

			Array2D<int> A(2, 2, *a);
			Array2D<int> C(1, 1, *c);

			Assert::AreEqual(minor(A, row, col) == C, true);
		}

		TEST_METHOD(AlliedMatTest1)
		{
			int a[3][3]
			{
				{ 1, 2, 3 },
				{ 4, 5, 6 },
				{ 7, 8, 0 }
			};

			int c[3][3]
			{
				{ -48, 42, -3 },
				{ 24, -21, 6 },
				{ -3, 6, -3 }
			};

			Array2D<int> A(3, 3, *a);
			Array2D<int> C(3, 3, *c);

			Assert::AreEqual(allied(A) == C, true);
		}

		TEST_METHOD(AlliedMatTest2)
		{
			int a[6][6]
			{
				{ 1, 0, 0, 0, 0, 0 },
				{ 0, 1, 0, 0, 0, 0 },
				{ 0, 0, 1, 0, 0, 0 },
				{ 0, 0, 0, 1, 0, 0 },
				{ 0, 0, 0, 0, 1, 0 },
				{ 0, 0, 0, 0, 0, 1 }
			};

			int c[6][6]
			{
				{ 1, 0, 0, 0, 0, 0 },
				{ 0, 1, 0, 0, 0, 0 },
				{ 0, 0, 1, 0, 0, 0 },
				{ 0, 0, 0, 1, 0, 0 },
				{ 0, 0, 0, 0, 1, 0 },
				{ 0, 0, 0, 0, 0, 1 }
			};

			Array2D<int> A(6, 6, *a);
			Array2D<int> C(6, 6, *c);

			Assert::AreEqual(allied(A) == C, true);
		}

		TEST_METHOD(TransponateTest1)
		{
			int a[3][3]
			{
				{ 0, 9, 22 },
				{ 4, 2, 5 },
				{ 23, 28, 11 }
			};

			int c[3][3]
			{
				{ 0, 4, 23 },
				{ 9, 2, 28 },
				{ 22, 5, 11 }
			};

			Array2D<int> A(3, 3, *a);
			Array2D<int> C(3, 3, *c);

			Assert::AreEqual(!A == C, true);
		}

		TEST_METHOD(TransponateTest2)
		{
			int a[3][3]
			{
				{ 1, 0, 0 },
				{ 0, 1, 0 },
				{ 0, 0, 1 }
			};

			int c[3][3]
			{
				{ 1, 0, 0 },
				{ 0, 1, 0 },
				{ 0, 0, 1 }
			};

			Array2D<int> A(3, 3, *a);
			Array2D<int> C(3, 3, *c);

			Assert::AreEqual(!A == C, true);
		}

		TEST_METHOD(TransponateTest3)
		{
			int a[3][4]
			{
				{ 18, 121, 3, 13 },
				{ 14, 101, 0, 1 },
				{ 0, 0, 1, 100 }
			};

			int c[4][3]
			{
				{ 18, 14, 0 },
				{ 121, 101, 0},
				{ 3, 0, 1 },
				{ 13, 1, 100 }
			};

			Array2D<int> A(3, 4, *a);
			Array2D<int> C(4, 3, *c);

			Assert::AreEqual(!A == C, true);
		}

		TEST_METHOD(InverseMatTest1)
		{
			double a[4][4]
			{
				{ 0, 3, -1, 2 },
				{ 2, 1, 0, 0 },
				{ -2, -1, 0, 2 },
				{ -5, 7, 1, 1 }
			};

			Array2D<double> A(4, 4, *a);
			Array2D<double> C(4, 4);
			C = inverse(inverse(A));

			for (int i = 0; i < 4; i++)
				for (int j = 0; j < 4; j++)
					Assert::AreEqual(abs(C[i][j] - A[i][j]) < 0.001, true);
		}

		TEST_METHOD(InverseMatTest2)
		{
			double a[4][4]
			{
				{ 1, 0, 0, 0 },
				{ 0, 1, 0, 0 },
				{ 0, 0, 1, 0 },
				{ 0, 0, 0, 1 }
			};

			Array2D<double> A(4, 4, *a);
			Array2D<double> C(4, 4);
			C = inverse(inverse(A));

			for (int i = 0; i < 4; i++)
				for (int j = 0; j < 4; j++)
					Assert::AreEqual(abs(C[i][j] - A[i][j]) < 0.001, true);
		}

		TEST_METHOD(InverseMatTest3)
		{
			double a[4][4]
			{
				{ -0.04, 0.46, 0.06, -0.04 },
				{ 0.08, 0.08, -0.12, 0.08 },
				{ -0.76, 1.24, 0.64, 0.24 },
				{ 0, 0.5, 0.5, 0 }
			};

			double c[4][4]
			{
				{ 0, 3, -1, 2 },
				{ 2, 1, 0, 0 },
				{ -2, -1, 0, 2 },
				{ -5, 7, 1, 1 }
			};


			Array2D<double> A(4, 4, *a);
			Array2D<double> C(4, 4, *c);
			Array2D<double> B(4, 4);
			B = inverse(A);

			for (int i = 0; i < 4; i++)
				for (int j = 0; j < 4; j++)
					Assert::AreEqual(abs(C[i][j] - B[i][j]) < 0.001, true);
		}

		TEST_METHOD(InverseMatTest4)
		{
			double a[4][4]
			{
				{ 0, 3, -1, 2 },
				{ 2, 1, 0, 0 },
				{ -2, -1, 0, 2 },
				{ -5, 7, 1, 1 }				
			};

			double c[4][4]
			{
				{ -0.04, 0.46, 0.06, -0.04 },
				{ 0.08, 0.08, -0.12, 0.08 },
				{ -0.76, 1.24, 0.64, 0.24 },
				{ 0, 0.5, 0.5, 0 }
			};


			Array2D<double> A(4, 4, *a);
			Array2D<double> C(4, 4, *c);
			Array2D<double> B(4, 4);
			B = inverse(A);

			for (int i = 0; i < 4; i++)
				for (int j = 0; j < 4; j++)
					Assert::AreEqual(abs(C[i][j] - B[i][j]) < 0.001, true);
		}

		TEST_METHOD(InverseMatTest5)
		{
			double a[3][3]
			{
				{ 10, 0, 0 },
				{ 0, 2, 0 },
				{ 0, 0, 5 }
			};

			double c[3][3]
			{
				{ 0.1, 0, 0 },
				{ 0, 0.5, 0 },
				{ 0, 0, 0.2 }
			};


			Array2D<double> A(3, 3, *a);
			Array2D<double> C(3, 3, *c);
			Array2D<double> B(3, 3);
			B = inverse(A);

			for (int i = 0; i < 3; i++)
				for (int j = 0; j < 3; j++)
					Assert::AreEqual(abs(C[i][j] - B[i][j]) < 0.001, true);
		}



	};
}