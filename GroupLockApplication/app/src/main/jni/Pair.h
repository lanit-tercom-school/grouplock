template <typename T, typename Q>
class Pair {
public:
    T x;
    Q y;
    Pair();
    Pair(T x, Q y);
    ~Pair(); 
};


template <typename T, typename Q>
Pair<T,Q>::Pair() {

}

template <typename T, typename Q>
Pair<T,Q>::Pair(T first, Q second) {
	x = first;
	y = second;
}

template <typename T, typename Q>
Pair<T,Q>:: ~Pair() {

}


