#include "stdafx.h"
#include "CppUnitTest.h"
#include "IntBytes.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace TestsIntBytes
{		
	TEST_CLASS(UnitTestForIntBytes)
	{
	public:

		TEST_METHOD(TestForPower1)
		{
			Assert::AreEqual(power(2, 6), 64, L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestForPower2)
		{
			Assert::AreEqual(power(2, 10), 1024, L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestForPower3)
		{
			Assert::AreEqual(power(2, 15), 64, L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestForCountBits1)
		{
			Assert::AreEqual(CountBits(4), 3, L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestForCountBits2)
		{
			Assert::AreEqual(CountBits(37), 6, L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestForCountBits3)
		{
			Assert::AreEqual(CountBits(7), 15, L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestForReverseChar1)
		{
			char S[14] = {'0','1','0','1','1','0','0','0','1','0','1','1','0','1'};

			char* A = new char[14];

			for(int i = 0; i < 14; i++)
			{
				A[i] = S[i];
			}

			char* B = new char[14];
			for(int i = 0; i < 14; i++)
			{
				B[i] = A[13 - i];
			}

			ReverseChar(A, 14);
			for(int i = 0; i < 14; i++)
				Assert::AreEqual(A[i], B[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestForReverseChar2)
		{
			char* A = new char[6];
			A[0] = '0';
			A[1] = '1';
			A[2] = '0';
			A[3] = '1';
			A[4] = '1';
			A[5] = '0';

			char* B = new char[6];
			for(int i = 0; i < 6; i++)
			{
				B[i] = A[5 - i];
			}

			char* C = ReverseChar(A, 6);
			for(int i = 0; i < 6; i++)
				Assert::AreEqual(A[i], B[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestForReverseChar3)
		{			
			char S[7] = {'0','1','0','1','1','0','0'};
			char* A = new char[7];

			for(int i = 0; i < 7; i++)
			{
				A[i] = S[i];
			}

			char* B = new char[7];
			for(int i = 0; i < 7; i++)
			{
				B[i] = A[6 - i];
			}

			ReverseChar(A, 7);

			B[4] = '1';
			for(int i = 0; i < 6; i++)
				Assert::AreEqual(A[i], B[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestForReverseInt1)
		{
			int S[14] = {4, 2, 9, 6, 0, 7, 2, 9, 4, 8, 3, 2, 4, 3};
			int* A = new int[14];

			for(int i = 0; i < 14; i++)
			{
				A[i] = S[i];
			}

			int* B = new int[14];
			for(int i = 0; i < 14; i++)
			{
				B[i] = A[13 - i];
			}

			ReverseInt(A, 14);

			for(int i = 0; i < 14; i++)
				Assert::AreEqual(A[i], B[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestForReverseInt2)
		{
			int S[7] = {4, 8, 9, 3, 6, 5, 7};
			int* A = new int[7];

			for(int i = 0; i < 7; i++)
			{
				A[i] = S[i];
			}

			int* B = new int[7];
			for(int i = 0; i < 7; i++)
			{
				B[i] = A[6 - i];
			}

			ReverseInt(A, 7);

			for(int i = 0; i < 7; i++)
				Assert::AreEqual(A[i], B[i], L"Test failed", LINE_INFO());

		}

	public:

		TEST_METHOD(TestForReverseInt3)
		{
			int S[6] = {7, 8, 2, 3, 5, 0};
			int* A = new int[6];

			for(int i = 0; i < 6; i++)
			{
				A[i] = S[i];
			}

			int* B = new int[6];
			for(int i = 0; i < 6; i++)
			{
				B[i] = A[5 - i];
			}

			ReverseInt(A, 6);

			B[4] = 1;
			for(int i = 0; i < 6; i++)
				Assert::AreEqual(A[i], B[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestForByteArrayInInt1)
		{
			char* A = new char[15];
			char S[15] = {'0','1','0','1','0','0','0','1','1','1','0','1','0','0','0'};
			for(int i = 0; i < 15; i++)
			{
				A[i] = S[i];
			}

			int* B = ByteArrayInInt(A, 3, 15);
			int* C = new int[5];
			int S1[5] = {2, 4, 3, 5, 0};
			
			for(int i = 0; i < 5; i++)
			{
				C[i] = S1[i];
			}

			for(int i = 0; i < 5; i++)			
				Assert::AreEqual(B[i], C[i], L"Test failed", LINE_INFO());
		}

		public:

		TEST_METHOD(TestForByteArrayInInt2)
		{
			char* A = new char[5];
			char S[5] = {'0','1','0','1','0'};
			for(int i = 0; i < 5; i++)
			{
				A[i] = S[i];
			}

			int* B = ByteArrayInInt(A, 3, 5);
			int* C = new int[2];
			int S1[2] = {1, 2};
			
			for(int i = 0; i < 2; i++)
			{
				C[i] = S1[i];
			}

			for(int i = 0; i < 2; i++)			
				Assert::AreEqual(B[i], C[i], L"Test failed", LINE_INFO());
		}

		public:

		TEST_METHOD(TestForByteArrayInInt3)
		{
			char* A = new char[8];
			char S[8] = {'0','1','0','0','1','0','1','0'};
			for(int i = 0; i < 8; i++)
			{
				A[i] = S[i];
			}

			int* B = ByteArrayInInt(A, 2, 8);
			int* C = new int[4];
			int S1[4] = {1, 0, 8, 2};
			
			for(int i = 0; i < 4; i++)
			{
				C[i] = S1[i];
			}

			for(int i = 0; i < 4; i++)			
				Assert::AreEqual(B[i], C[i], L"Test failed", LINE_INFO());
		}

		public:

		TEST_METHOD(TestForIntArrayInBytes1)
		{
			int* C = new int[4];
			int S1[4] = {1, 0, 2, 2};			
			for(int i = 0; i < 4; i++)
			{
				C[i] = S1[i];
			}

			char* A = new char[8];
			char S[8] = {'0','1','0','0','1','0','1','0'};
			for(int i = 0; i < 8; i++)
			{
				A[i] = S[i];
			}
			
			char* B = IntArrayInBytes(C, 2, 4);
			int dif = 4 * 2 - 8;
			for(int i = 0; i < 4; i++)			
				Assert::AreEqual(B[i], A[i], L"Test failed", LINE_INFO());
		}

		public:

		TEST_METHOD(TestForIntArrayInBytes2)
		{
			int* C = new int[2];
			int S1[2] = {1, 2};			
			for(int i = 0; i < 2; i++)
			{
				C[i] = S1[i];
			}

			char* A = new char[5];
			char S[5] = {'0','1','0','1','0'};
			for(int i = 0; i < 5; i++)
			{
				A[i] = S[i];
			}
			
			char* B = IntArrayInBytes(C, 3, 2);
			int dif = 3 * 2 - 5;

			for(int i = 4; i >= 0; i--)			
				Assert::AreEqual(B[i + dif], A[i], L"Test failed", LINE_INFO());
		}

		public:

		TEST_METHOD(TestForIntArrayInBytes3)
		{
			int* C = new int[5];
			int S1[5] = {2, 7, 3, 5, 0};			
			for(int i = 0; i < 5; i++)
			{
				C[i] = S1[i];
			}

			char* A = new char[15];
			char S[15] = {'0','1','0','1','0','0','0','1','1','1','0','1','0','0','0'};
			for(int i = 0; i < 15; i++)
			{
				A[i] = S[i];
			}
			
			char* B = IntArrayInBytes(C, 3, 5);
			int dif = 3 * 5 - 15;
			for(int i = 14; i >= 0; i++)			
				Assert::AreEqual(B[i + dif], A[i], L"Test failed", LINE_INFO());
		}
	};
}
