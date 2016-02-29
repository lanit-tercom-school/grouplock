/*
input: any number x (maybe x is prime) and digit
output: prime number more than x and has digit from input
*/

using namespace std;

namespace PrimeNum{

	static int list_primeNum[100001] {
    #include "primeNumbers.txt"
	};

	int pow(int deg) {
		long long res = 1;
		for (int i = 1; i <= deg; ++i) res *= 10;
		return res;
	}
	
	int choice_PrimeNum(int x, int digitX) {
		
		long long mNumber_digitX = pow(digitX - 1);
		long long a = mNumber_digitX;
		
		if (x > mNumber_digitX) {
			a = x;
		}
		for (int i = a; i < mNumber_digitX * 10; ++i) {
			if (list_primeNum[i] > x) return list_primeNum[i];
		}
	}
}