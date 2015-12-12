#include "fraction.h"

Fraction::Fraction() {
}

Fraction::Fraction(int x, int y) {
	c = x;
	x = y;
}

int Fraction::NOD(int x, int y){
	if (y == 0)
       return x;
    else
      return NOD(y, x % y);
}

int Fraction::operator%(int mod){
	while (NOD(c,z) != z){
       c +=mod;
    }
    return c/z;
}

Fraction Fraction::operator+(Fraction other){
    Fraction s;
    s.c = c*other.z+other.c*z;
    s.z = z*other.z;
    int nod = NOD(s.c, s.z);
    s.c /= nod;
    s.z /= nod;
    return s;
}

Fraction Fraction::operator-(Fraction other){
    Fraction s;
    s.c = c*other.z-other.c*z;
    s.z = z*other.z;
    int nod = NOD(s.c, s.z);
    s.c /= nod;
    s.z /= nod;
    return s;
}

Fraction Fraction::operator*(Fraction other){
    Fraction s;
    s.c = c*other.c;
    s.z = z*other.z;
    int nod = NOD(s.c, s.z);
    s.c /= nod;
    s.z /= nod;
    return s;
 }
 
Fraction Fraction::operator/(Fraction other){
    Fraction s;
    s.c = c*other.z;
    s.z = z*other.c;
    int nod = NOD(s.c, s.z);
    s.c /= nod;
    s.z /= nod;
    return s;
}

