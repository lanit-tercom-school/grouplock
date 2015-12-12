template <typename T>
class Poly {
public:
    T *coefPtr; // указатель на массив коэффициентов
    int deg; // степень полинома
    Poly(T *coef, int n);
    ~Poly();
    T GetPx(int x);
    // Matrix GetPx(int x, Matrix M); вычисление значения в точке по модулю М
};


template <typename T>
Poly<T>::Poly(T *coef, int n) {
    deg = n;
    coefPtr = new T[deg];
    for (int i = 0; i < n + 1; i++)
        coefPtr[i] = coef[i];
}


template <typename T>
Poly<T>:: ~Poly()  {
     delete [] coefPtr;
}

template <typename T>
T Poly<T>::GetPx(int x) {
	//TODO
    return 0;
}

