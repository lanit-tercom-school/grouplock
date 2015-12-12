#include <cmath>
#include <iostream>
#include <cstdlib>
#include "Pair.h"
#include "Poly.h"

using namespace std;

template <typename T>
class SecretScharing {
public:
	static int GetPrimeNumber(int x, int digit);
	static int GetCountDigit(int x);
	static Pair<int, T> * GetKeys(int secret, int k, int n, int & p);
	//Pair<int, T> * GetKeys(T secret, int k, int n);
	static T GetCoefPoly(int mod);
};

template <typename T>
int SecretScharing<T>::GetPrimeNumber(int x, int digit) {
	return 37;
}

template <typename T>
int SecretScharing<T>::GetCountDigit(int x) {
	int res = 1;
	while (x / 10 != 0){
		res++;
		x /= 10;
	}
	return res;
}

template <typename T> //for int
T SecretScharing<T>::GetCoefPoly(int mod) {
	return rand() % (mod - 1) + 1;
}

template <typename T>//for int secret
Pair<int, T> * SecretScharing<T>::GetKeys(int secret, int k, int n, int & p) {
	int digit = SecretScharing<int>::GetCountDigit(secret);
	p = SecretScharing<int>::GetPrimeNumber(secret, digit); //mod
	
	T * coef = new T[k - 1];
	coef[0] = secret;
	for (int i = 1 ; i < k - 1; i++)
		coef[i] = SecretScharing<int>::GetCoefPoly(p);
	Poly<T, int> fx (coef, k - 1);
	Pair<int, T> * keys = new Pair<int, T>[n];
	int x;
	T y;
	for (int i = 1; i <= n; i++) {
		x = i;
		y = fx.GetPx(x, p);
		Pair<int, T> p (x,y);
		keys[i - 1] = p;
	}
	return keys;
}
