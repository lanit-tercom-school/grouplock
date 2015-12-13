#ifndef FRACTION_H
#define FRACTION_H

class Fraction {
public:
    int c;
    int z;
    Fraction(){
};
    Fraction(int x, int y){
		c = x;
		z = y;
	};
    int NOD(int x, int y){
		if (y == 0)
		return x;
		else
		return NOD(y, x % y);
	};
    int operator%(int mod){
		if (c == mod)
			return 0;
		while (NOD(c,z) != z){
		c +=mod;
		}
		return c/z;
	};
	Fraction operator+(Fraction other){
		Fraction s;
		s.c = c*other.z+other.c*z;
		s.z = z*other.z;
		int nod = NOD(s.c, s.z);
		s.c /= nod;
		s.z /= nod;
	return s;
	};
	Fraction operator-(Fraction other){
		Fraction s;
		s.c = c*other.z-other.c*z;
		s.z = z*other.z;
		int nod = NOD(s.c, s.z);
		s.c /= nod;
		s.z /= nod;
		return s;
	};
	Fraction operator*(Fraction other){
		Fraction s;
		s.c = c*other.c;
		s.z = z*other.z;
		int nod = NOD(s.c, s.z);
		s.c /= nod;
		s.z /= nod;
		return s;
	};
    Fraction operator/(Fraction other){
		Fraction s;
		s.c = c*other.z;
		s.z = z*other.c;
		int nod = NOD(s.c, s.z);
		s.c /= nod;
		s.z /= nod;
		return s;
	};
};

#endif // FRACTION_H
