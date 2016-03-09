#include "stdafx.h"
#include "CppUnitTest.h"
#include "IntBytes.h"

using namespace std;
using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace TestsIntBytes
{		
	TEST_CLASS(UnitTestForIntBytes)
	{

	public:

		TEST_METHOD(TestForByteArrayInInt)
		{
			IntBytes test(3);
			char* A = new char[15];
			//char S[] = {40, 232};
            char S[15] = {'0','1','0','1','0','0','0','1','1','1','0','1','0','0','0'};
			//A = S;

			for(int i = 0; i < 15; i++)
			{
				A[i] = S[i];
			}

			int* B = test.byte_array_in_int(A, 15);
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

		TEST_METHOD(TestForByteArrayInIntShouldFail)
		{
			IntBytes test(2);
			char* A = new char[8];
			//char S[] = {112};
			char S[8] = {'0','1','1','1','0','0','0','0'};

			for(int i = 0; i < 8; i++)
			{
				A[i] = S[i];
			}

			int* B = test.byte_array_in_int(A, 8);
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

		TEST_METHOD(TestForIntArrayInBytes)
		{
			IntBytes test(2);
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

			char* B = test.int_array_in_bytes(C, 4);
			int dif = 4 * 2 - 8;
			for(int i = 0; i < 4; i++)			
				Assert::AreEqual(B[i], A[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(TestForIntArrayInBytesShouldFail)
		{
			IntBytes test(3);
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

			char* B = test.int_array_in_bytes(C, 5);
			int dif = 3 * 5 - 15;
			for(int i = 14; i >= 0; i++)			
				Assert::AreEqual(B[i + dif], A[i], L"Test failed", LINE_INFO());
		}
	};
}
