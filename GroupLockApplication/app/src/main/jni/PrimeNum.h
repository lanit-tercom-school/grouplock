/*
input: any number x (maybe x is prime) and digit
output: prime number more than x and has digit from input
*/

#include <fstream>
using namespace std;

namespace PrimeNum{
	static int list_primeNum[100001];
	ifstream in("primeNumbers.in");

	class prime {

	public:
		static int choice_PrimeNum(int x, int digitP);


	private:
		int pow(int deg);
		void read(int n);
		
	};

	void read(int n) {
		for (int i = 0; i <= n; ++i) {
			in >> list_primeNum[i];
		}
	}

	int pow(int deg) {
		long long res = 1;
		for (int i = 1; i <= deg; ++i) res *= 10;
		return res;
	}

	int choice_PrimeNum(int x, int digitX) {
		long long a = pow(digitX - 1);
		read(a * 10);
		for (int i = a; i < a * 10; ++i) {
			if (list_primeNum[i] > x) return list_primeNum[i];
		}
	}
}