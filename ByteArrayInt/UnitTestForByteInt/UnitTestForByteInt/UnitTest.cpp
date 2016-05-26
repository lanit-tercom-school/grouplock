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

		TEST_METHOD(test_for_byte_array_in_int_acc3){
			IntBytes test(3);
			vector<unsigned char> S; //0 010 100 011 101 000
			S.insert(S.end(), 40);//00101000
			S.insert(S.end(), 232);//11101000

			vector<int> B = test.bits_array_in_int(S);
			vector<int> C(6);
			int S1[6] = {0, 2, 4, 3, 5, 0};

			for(int i = 0; i < 5; i++){
				C[i] = S1[i];
			}

			for(int i = 0; i < 5; i++)			
				Assert::AreEqual(B[i], C[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(test_for_byte_array_in_int_acc7){
			IntBytes test(7);
			vector<unsigned char> S; //00 1010001 1101000
			S.insert(S.end(), 40); //00101000
			S.insert(S.end(), 232); //11101000

			vector<int> B = test.bits_array_in_int(S);
			vector<int> C(3);
			int S1[3] = {0, 81, 104};

			for(int i = 0; i < 3; i++){
				C[i] = S1[i];
			}

			for(int i = 0; i < 3; i++)			
				Assert::AreEqual(B[i], C[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(test_for_byte_array_in_int_acc17){
			
			IntBytes test(17);
			vector<unsigned char> S; //00000100 00000000100000100 01000000101000100
		   
			S.insert(S.begin(), 68); //01000100
			S.insert(S.begin(), 129); //10000001
			S.insert(S.begin(), 8); //00001000
			S.insert(S.begin(), 2); //00000010 
			S.insert(S.begin(), 16); //00010000
			S.insert(S.begin(), 0); //00

			vector<int> B = test.bits_array_in_int(S);
			vector<int> C(3);
			int S1[3] = {4, 260, 33092};

			for(int i = 0; i < 3; i++){
				C[i] = S1[i];
			}

			Assert::AreEqual(B.size(), C.size(), L"Test failed", LINE_INFO());

			for(int i = 0; i < C.size(); i++)			
				Assert::AreEqual(B[i], C[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(test_for_int_array_in_bytes_acc2){
			IntBytes test(2);
			vector<int> C(4);
			int S1[4] = {1, 0, 2, 2};			
			for(int i = 0; i < 4; i++){
				C[i] = S1[i];
			}

			vector<unsigned char> S; 
			S.insert(S.end(), 74);//01001010
			vector<unsigned char> B = test.int_array_in_bits(C);

			Assert::AreEqual(B.size(), S.size(), L"Test failed", LINE_INFO());

			for(int i = 0; i < S.size(); i++)			
				Assert::AreEqual(B[i], S[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(test_for_int_array_in_bytes_acc6){
			IntBytes test(6);
			vector<int> C(7);
			int S1[7] = {1, 0, 2, 2, 8, 5, 4};	//000001 000000 000010 000010 001000 000101 000100
 
			for(int i = 0; i < 7; i++){
				C[i] = S1[i];
			}

			vector<unsigned char> S; 
			S.insert(S.begin(), 68); //01000100
			S.insert(S.begin(), 129); //10000001
			S.insert(S.begin(), 8); //00001000
			S.insert(S.begin(), 2); //00000010
			S.insert(S.begin(), 16); //00010000
			S.insert(S.begin(), 0); //00

			vector<unsigned char> B = test.int_array_in_bits(C);

			Assert::AreEqual(B.size(), S.size(), L"Test failed", LINE_INFO());

			for(int i = 0; i < S.size(); i++)			
				Assert::AreEqual(B[i], S[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(test_for_int_array_in_bytes_acc16){
			IntBytes test(16);
			vector<int> C(3);
			int S1[3] = {16, 520, 33092}; //0000010000 0000001000001000 1000000101000100
			for(int i = 0; i < 3; i++){
				C[i] = S1[i];
			}

			vector<unsigned char> S; 
			S.insert(S.begin(), 68); //01000100
			S.insert(S.begin(), 129); //10000001
			S.insert(S.begin(), 8); //00001000
			S.insert(S.begin(), 2); //00000010
			S.insert(S.begin(), 16); //00010000
			S.insert(S.begin(), 0); //00

			vector<unsigned char> B = test.int_array_in_bits(C);

			Assert::AreEqual(B.size(), S.size(), L"Test failed", LINE_INFO());

			for(int i = 0; i < S.size(); i++)			
				Assert::AreEqual(B[i], S[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(test_for_byte_array_in_int_fail){

			IntBytes test(33);
			vector<unsigned char> S; //000001000 000000010000010001000000101000100

			S.insert(S.begin(), 68); //01000100
			S.insert(S.begin(), 129); //10000001
			S.insert(S.begin(), 8); //00001000
			S.insert(S.begin(), 2); //00000010
			S.insert(S.begin(), 16); //00010000
			S.insert(S.begin(), 0); //00

			vector<int> B = test.bits_array_in_int(S);
			vector<int> C;

			Assert::AreEqual(B.size(), C.size(), L"Test failed", LINE_INFO());

			for(int i = 0; i < C.size(); i++)			
				Assert::AreEqual(B[i], C[i], L"Test failed", LINE_INFO());
		}

	public:

		TEST_METHOD(test_for_int_array_in_bytes_fail){
			IntBytes test(35);
			vector<int> C(1);
			C.insert(C.end(), 74);

			vector<unsigned char> S;
			vector<unsigned char> B = test.int_array_in_bits(C);

			Assert::AreEqual(B.size(), S.size(), L"Test failed", LINE_INFO());

			for(int i = 0; i < S.size(); i++)			
				Assert::AreEqual(B[i], S[i], L"Test failed", LINE_INFO());
		}
	};
}
