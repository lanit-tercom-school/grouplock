#include <cmath>

template <typename T, typename Q>
class Poly {
public:
    T *coefPtr; // указатель на массив коэффициентов
    int deg; // степень полинома
    Poly(T *coef, int n);
    ~Poly();
    T GetPx(int x);
    T GetPx(int x, Q mod); //вычисление значения в точке по модулю М
};


template <typename T, typename Q>
Poly<T, Q>::Poly(T *coef, int n) {
    deg = n;
    coefPtr = new T[deg];
    for (int i = 0; i < n + 1; i++)
        coefPtr[i] = coef[i];
}


template <typename T, typename Q>
Poly<T, Q>:: ~Poly()  {
     delete [] coefPtr;
}

template <typename T, typename Q>
T Poly<T, Q>::GetPx(int x) {
	T result = coefPtr[0];
	for (int i = 1; i < deg + 1; i++)
        result += coefPtr[i] * pow(x,i);
    return result;
}

template <typename T, typename Q>
T Poly<T, Q>::GetPx(int x, Q mod) {
	T result = GetPx(x);
	return result % mod;
}

