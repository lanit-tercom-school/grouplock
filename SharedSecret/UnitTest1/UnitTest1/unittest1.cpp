#include "stdafx.h"
#include "CppUnitTest.h"
#include "tnt.h"
#include "partsSecret.h"
#include "Poly.h"
using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTest1
{		
	TEST_CLASS(UnitTest1)
	{
	public:
		
		TEST_METHOD(makePoly) {
			vector<Array2D<int>> v;
			int degPol = 4;
			int dimA = 1;
			Array2D<int> A (dimA, dimA);
			A[0][0] = 1;
			int p = 2;

			getP(degPol, v, A, dimA, p);
			Poly pp(v, degPol, dimA);
			Assert::AreEqual(pp.deg, degPol);
			Assert::AreEqual(pp.dim, dimA);
			int g = pp.coefPtr.size();
			Assert::AreEqual(g, degPol + 1);
		}

		TEST_METHOD(getParts) {
			int minKolKeys = 2;
			int kolParts = 4;
			int dimA = 3;
			Array2D<int> A(dimA, dimA);
			A[0][0] = 999;
			A[1][0] = 2;
			A[0][1] = 3;
			A[1][1] = 999;
			A[2][0] = 0;
			A[0][2] = 1;
			A[2][2] = 999;
			A[1][2] = 3;
			A[2][1] = 4;
			parts p = getPartsK(minKolKeys, A, dimA, kolParts);
			Assert::AreEqual(p.kolParts, kolParts); 
			Assert::AreEqual(p.deg, minKolKeys + 1);
			int kSize = p.K_i.size();
			int xSize = p.X.size();
			Assert::AreEqual(kSize, kolParts);
			Assert::AreEqual(xSize, kolParts);
		}

		TEST_METHOD(getSecret) {
			int minKolKeys = 2;
			int kolParts = 4;
			int dimA = 3;
			Array2D<int> A(dimA, dimA);
			A[0][0] = 57;
			A[1][0] = 2;
			A[0][1] = 3;
			A[1][1] = 19;
			A[2][0] = 0;
			A[0][2] = 1;
			A[2][2] = 999;
			A[1][2] = 3;
			A[2][1] = 4;
			parts p = getPartsK(minKolKeys, A, dimA, kolParts);
			Array2D<Fraction> B(dimA, dimA);
			B = makeSecret(p.K_i, p.X, p.deg, p.p, dimA);
			string answ = "5719999";
			string s = "";
			for (int i = 0; i < dimA; ++i) {
				s += to_string(B[i][i].c);
			}
			Assert::AreEqual(s, answ);
		}

	};
}