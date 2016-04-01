#include "stdafx.h"
#include "CppUnitTest.h"
#include "tnt.h"
#include "fraction.h"

using namespace TNT;
using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTestForFractionMatrix
{		
	TEST_CLASS(UnitTestForFractionMatrix)
	{	
	
	public:

		TEST_METHOD(TestMethodCopy){
			Array2D<Fraction>A(3, 3);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 3; j++){
					A[i][j] = Fraction(i,j+24);
				}
				Array2D<Fraction> B = A.copy();
				for(int i = 0; i < 3; i++)
					for(int j = 0; j < 3; j++){
						Assert::AreEqual(std::string(A[i][j].ToString()), std::string(B[i][j].ToString()));
					}
		}
	public:

		TEST_METHOD(TestPropertyDim){
			Array2D<Fraction> A(3, 6);
			int m = A.dim1();
			int n = A.dim2();
			Assert::AreEqual(m, 3, L"Test failed", LINE_INFO());
			Assert::AreEqual(n, 6, L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestOperatorPlus){
			Array2D<Fraction> A(3, 6);
			Array2D<Fraction> B(3, 6);
			Array2D<Fraction> D(3, 6);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 6; j++){
					A[i][j] = Fraction(i, j + 24);
					B[i][j] = Fraction(j, i + 6);
					D[i][j] = A[i][j] + B[i][j];
				}
				Array2D<Fraction> C = A + B;

				for(int i = 0; i < 3; i++)
					for(int j = 0; j < 6; j++){
						Assert::AreEqual(std::string(C[i][j].ToString()), std::string(D[i][j].ToString()));
					}	
		}

	public:

		TEST_METHOD(TestOperatorSubtraction){
			Array2D<Fraction> A(3, 6);
			Array2D<Fraction> B(3, 6);
			Array2D<Fraction> D(3, 6);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 6; j++){
					A[i][j] = Fraction(i, j + 24);
					B[i][j] = Fraction(j, i + 6);
					D[i][j] = A[i][j] - B[i][j];
				}
				Array2D<Fraction> C = A - B;

				for(int i = 0; i < 3; i++)
					for(int j = 0; j < 6; j++){
						Assert::AreEqual(std::string(C[i][j].ToString()), std::string(D[i][j].ToString()));
					}	
		}

	public:

		TEST_METHOD(TestOperatorMulty){
			Array2D<Fraction> A(3, 6);
			Array2D<Fraction> B(3, 6);
			Array2D<Fraction> D(3, 6);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 6; j++){
					A[i][j] = Fraction(i, j + 24);
					B[i][j] = Fraction(j, i + 6);
					D[i][j] = A[i][j] * B[i][j];
				}
				Array2D<Fraction> C = A * B;

				for(int i = 0; i < 3; i++)
					for(int j = 0; j < 6; j++){
						Assert::AreEqual(std::string(C[i][j].ToString()), std::string(D[i][j].ToString()));
					}	
		}

	public:

		TEST_METHOD(TestOperatorDiv){
			Array2D<Fraction> A(3, 6);
			Array2D<Fraction> B(3, 6);
			Array2D<Fraction> D(3, 6);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 6; j++){
					A[i][j] = Fraction(i, j + 24);
					B[i][j] = Fraction(j + 9, i + 6);
					D[i][j] = A[i][j]/B[i][j];
				}

				Array2D<Fraction> C = A / B;

				for(int i = 0; i < 3; i++)
					for(int j = 0; j < 6; j++){
						Assert::AreEqual(std::string(C[i][j].ToString()), std::string(D[i][j].ToString()));
					}	
		}

	public:

		TEST_METHOD(TestMutMult){
			Array2D<Fraction> A(3, 6);
			Array2D<Fraction> B(6, 5);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 6; j++){
					A[i][j] = Fraction(i, j + 24);
				}
				for(int i = 0; i < 6; i++)
					for(int j = 0; j < 5; j++){
						B[i][j] = Fraction(i + 9, j + 2);
					}
					Array2D<Fraction> C = matmult(A, B);
					Array2D<Fraction> D(3, 5);
					for(int i = 0; i < 3; i++)
						for(int j = 0; j < 5; j++)
							for(int k = 0; k < 6; k++){
								D[i][j] = A[i][k] * B[k][j];
							}
		}

	public:

		TEST_METHOD(TestEqual){
			Array2D<Fraction> A(3, 6);
			Array2D<Fraction> B(3, 6);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 3; j++){
					A[i][j] = B[i][j] = Fraction(i, j + 2);
				}

				bool f = A == B;
				Assert::AreEqual(f, true, L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestScalar){
			Fraction p = Fraction(13, 17);
			Array2D<Fraction> A(3, 3);
			Array2D<Fraction> B(3, 3);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 3; j++){
					A[i][j] = Fraction(i, j + 24);
				}
				Array2D<Fraction> C = p * A;
				Array2D<Fraction> D = A * p;
		}

	public:
		//расмотрено только взятие по модулю целого числа
		TEST_METHOD(TestOperatorMod){
			Array2D<Fraction> A(3, 6);
			Array2D<Fraction> B(3, 6);
			int p = 23;
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 6; j++){
					A[i][j] = Fraction(i, j + 24);
					B[i][j] = Fraction(j, i + 6);
				}
				Array2D<Fraction> C = A % p; // Взятие матрицы по модулю p, т.е. каждый элемент будет взят по этому модулю
				//Array2D<Fraction> D = A % B;				
		}
	public:

		TEST_METHOD(TestDET){
			Array2D<Fraction> A(3, 3);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 3; j++){
					A[i][j] = Fraction(i, j + 24);
				}
				Fraction d = det(A);
		}

	public:

		TEST_METHOD(TestOperatorMinor){
			Array2D<Fraction> A(3, 6);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 6; j++){
					A[i][j] = Fraction(i, j + 24);
				}
				Array2D<Fraction> C = minor(A, 2, 4);
		}

	public:

		TEST_METHOD(TestOperatorAllied){
			Array2D<Fraction> A(3, 6);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 6; j++){
					A[i][j] = Fraction(i, j + 24);
				}
				Array2D<Fraction> C = allied(A);
		}

	public:

		TEST_METHOD(TestOperatorTrans){
			Array2D<Fraction> A(3, 6);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 6; j++){
					A[i][j] = Fraction(i, j + 24);
				}
				Array2D<Fraction> C = !A;
		}

	public:

		TEST_METHOD(TestOperatorInverse){
			Array2D<Fraction> A(3, 6);
			for(int i = 0; i < 3; i++)
				for(int j = 0; j < 6; j++){
					A[i][j] = Fraction(i, j + 24);
			}
			Array2D<Fraction> C = inverse(A);
		}
	};
}
