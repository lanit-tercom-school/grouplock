#include "stdafx.h"
#include "CppUnitTest.h"
#include "fraction.h"
#include "tnt.h"

using namespace TNT;
using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTestForFractionWithMatrix
{
	TEST_CLASS(UnitTests)
	{

	public:
		TEST_METHOD(TestCopy){ 
			Array2D<Fraction> A(3, 6); 
			Array2D<Fraction> B(3, 6); 
			Array2D<Fraction> D(3, 6); 
			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					A[i][j] = B[i][j] = Fraction(i, j + 24);
				} 

			Array2D<Fraction> C = A.copy(); 

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					Assert::AreEqual(std::string(B[i][j].ToString()), std::string(C[i][j].ToString()));
			} 
		}

	public:
		TEST_METHOD(TestDim){ 
			Array2D<Fraction> A(3, 6); 
			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					A[i][j] = Fraction(i, j + 24);
				} 

			int n = A.dim1();
			int m = A.dim2();
			Assert::AreEqual(n, 3, L"Test failed", LINE_INFO());
			Assert::AreEqual(m, 6, L"Test failed", LINE_INFO());
		}

	public:
		TEST_METHOD(TestOperatorPlus){ 
			Array2D<Fraction> A(3, 6); 
			Array2D<Fraction> B(3, 6); 
			Array2D<Fraction> D(3, 6); 
			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					A[i][j] = Fraction(i, j + 24);
					B[i][j] = Fraction(i + 9, j + 2);
					D[i][j] = A[i][j] + B[i][j]; 
				} 

			Array2D<Fraction> C = A + B; 

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					Assert::AreEqual(std::string(D[i][j].ToString()), std::string(C[i][j].ToString()));
			} 
		}

	public:
		TEST_METHOD(TestOperatorSubstraction){ 
			Array2D<Fraction> A(3, 6); 
			Array2D<Fraction> B(3, 6); 
			Array2D<Fraction> D(3, 6); 
			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					A[i][j] = Fraction(i, j + 24);
					B[i][j] = Fraction(i + 9, j + 2);
					D[i][j] = A[i][j] - B[i][j]; 
				} 

			Array2D<Fraction> C = A - B; 

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					Assert::AreEqual(std::string(D[i][j].ToString()), std::string(C[i][j].ToString()));
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
					B[i][j] = Fraction(i + 9, j + 2);
					D[i][j] = A[i][j] * B[i][j]; 
			} 

			Array2D<Fraction> C = A * B; 

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					Assert::AreEqual(std::string(D[i][j].ToString()), std::string(C[i][j].ToString()));
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
					B[i][j] = Fraction(i + 9, j + 2);
					D[i][j] = A[i][j] / B[i][j]; 
				} 

			Array2D<Fraction> C = A / B; 

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					Assert::AreEqual(std::string(D[i][j].ToString()), std::string(C[i][j].ToString()));
			} 
		}

		//рассматривается только взятие по модулю числа
	public:
		TEST_METHOD(TestOperatorMod){ 
			Array2D<Fraction> A(3, 6);
			Array2D<Fraction> B(3, 6);
			int p = 23;
			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					A[i][j] = Fraction(i, j + 24);
					B[i][j] = A[i][j] % p;
			} 

			Array2D<Fraction> C = A % p; 

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					Assert::AreEqual(std::string(B[i][j].ToString()), std::string(C[i][j].ToString()));
			} 
		}

	public:
		TEST_METHOD(TestMatMult){ 
			Array2D<Fraction> A(3, 6); 
			Array2D<Fraction> B(6, 5); 
			Array2D<Fraction> D(3, 5); 

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 5; j++){ 
					D[i][j] = 0;				
			}

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					A[i][j] = Fraction(i, j + 24);				
			}

			for(int i = 0; i < 6; i++) 
				for(int j = 0; j < 5; j++){ 
					B[i][j] = Fraction(i + 9, j + 2);				
			}

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 5; j++)
					for(int k = 0; k < 6; k++){ 
							D[i][j] += A[i][k] * B[k][j]; 
			}

			Array2D<Fraction> C = matmult(A, B); 

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 5; j++){ 
					Assert::AreEqual(std::string(D[i][j].ToString()), std::string(C[i][j].ToString()));
			} 
		}

	public:
		TEST_METHOD(TestAreEqual){ 
			Array2D<Fraction> A(3, 6); 
			Array2D<Fraction> B(3, 6); 
			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					A[i][j] = B[i][j] = Fraction(i, j + 24);
				} 

			bool f = A == B;
			Assert::AreEqual(f, true, L"Test failed", LINE_INFO());
		}

	public:
		TEST_METHOD(TestScalar){ 
			Array2D<Fraction> A(3, 6);
			Array2D<Fraction> B(3, 6);
			Array2D<Fraction> C(3, 6);
			Fraction p = Fraction(13, 17);

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					A[i][j] = Fraction(i, j + 24);
					B[i][j] = A[i][j] * p;
					C[i][j] = p * A[i][j];
				} 

			Array2D<Fraction> B1 = A * p;
			Array2D<Fraction> C1 = p * A;

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){ 
					Assert::AreEqual(std::string(B[i][j].ToString()), std::string(B1[i][j].ToString()));
					Assert::AreEqual(std::string(C[i][j].ToString()), std::string(C1[i][j].ToString()));
			} 
		}

	public:
		TEST_METHOD(TestDET){ 
			Array2D<Fraction> A(3, 3);
			A[0][0] = Fraction(7, 24);
			A[0][1] = Fraction(9, 25);
			A[0][2] = Fraction(7, 26);
			A[1][0] = Fraction(13, 24);
			A[1][1] = Fraction(12, 25);
			A[1][2] = Fraction(12, 26);
			A[2][0] = Fraction(17, 24);
			A[2][1] = Fraction(17, 25);
			A[2][2] = Fraction(17, 26);

			Fraction a = det(A);
			Fraction det = Fraction(-17, 7800);
			Assert::AreEqual(std::string(a.ToString()), std::string(det.ToString()));
		}

    public:
		TEST_METHOD(TestTrans){ 		
			Array2D<Fraction> A(3, 6);
			Array2D<Fraction> D(6, 3);
			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 6; j++){
					A[i][j] = Fraction(i + 9, j + 2);
					D[j][i] = A[i][j];
			}
			
			Array2D<Fraction> C = !A;
			for(int i = 0; i < 6; i++) 
				for(int j = 0; j < 3; j++)
					Assert::AreEqual(std::string(D[i][j].ToString()), std::string(C[i][j].ToString()));
		}

    public:
		TEST_METHOD(TestMinor){ 
			Array2D<Fraction> A(3, 3);
			Array2D<Fraction> M(2, 2);
			A[0][0] = Fraction(7, 24);
			A[0][1] = M[0][0] = Fraction(9, 25);
			A[0][2] = M[0][1] = Fraction(7, 26);
			A[1][0] = Fraction(13, 24);
			A[1][1] = Fraction(12, 25);
			A[1][2] = Fraction(12, 26);
			A[2][0] = Fraction(17, 24);
			A[2][1] = M[1][0] = Fraction(17, 25);
			A[2][2] = M[1][1] = Fraction(17, 26);

			Array2D<Fraction> C = minor(A, 1, 0);
			for(int i = 0; i < 2; i++) 
				for(int j = 0; j < 2; j++){
					Assert::AreEqual(std::string(M[i][j].ToString()), std::string(C[i][j].ToString()));
			}
		}

   public:
		TEST_METHOD(TestAllied){ 
			Array2D<Fraction> A(3, 3);
			Array2D<Fraction> M(3, 3);
			A[0][0] = Fraction(7, 24);
			A[0][1] = Fraction(9, 25);
			A[0][2] = Fraction(7, 26);
			A[1][0] = Fraction(13, 24);
			A[1][1] = Fraction(12, 25);
			A[1][2] = Fraction(12, 26);
			A[2][0] = Fraction(17, 24);
			A[2][1] = Fraction(17, 25);
			A[2][2] = Fraction(17, 26);

            M[0][0] = 0;
			M[0][1] = Fraction(-17, 624);
			M[0][2] = Fraction(17, 600);
			M[1][0] = Fraction(-17, 325);
			M[1][1] = 0;
			M[1][2] = Fraction(17, 300);
			M[2][0] = Fraction(12, 325);
			M[2][1] = Fraction(7, 624);
			M[2][2] = Fraction(-11, 200);

			Array2D<Fraction> C = allied(A);
			
			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 3; j++){
					Assert::AreEqual(std::string(M[i][j].ToString()), std::string(C[i][j].ToString()));
			}
		}

	public:
		TEST_METHOD(TestInverse){ 
			Array2D<Fraction> A(3, 3);
			Array2D<Fraction> M(3, 3);
			A[0][0] = Fraction(7, 24);
			A[0][1] = Fraction(9, 25);
			A[0][2] = Fraction(7, 26);
			A[1][0] = Fraction(13, 24);
			A[1][1] = Fraction(12, 25);
			A[1][2] = Fraction(12, 26);
			A[2][0] = Fraction(17, 24);
			A[2][1] = Fraction(17, 25);
			A[2][2] = Fraction(17, 26);

            M[0][0] = 0;
			M[0][1] = 24;
			M[0][2] = Fraction(-288, 17);
			M[1][0] = Fraction(25, 2);
			M[1][1] = 0;
			M[1][2] = Fraction(-175, 34);
			M[2][0] = -13;
			M[2][1] = -26;
			M[2][2] = Fraction(429, 17);

			Array2D<Fraction> C = inverse(A);

			Fraction a1 = C[0][0];
			Fraction a2 = C[0][1];
			Fraction a3 = C[0][2];
			Fraction a4 = C[1][0];
			Fraction a5 = C[1][1];
			Fraction a6 = C[1][2];
			Fraction a7 = C[2][0];
			Fraction a8 = C[2][1];
			Fraction a9 = C[2][2];

			for(int i = 0; i < 3; i++) 
				for(int j = 0; j < 3; j++){
					Assert::AreEqual(std::string(M[i][j].ToString()), std::string(C[i][j].ToString()));
			}
		}
	};
}