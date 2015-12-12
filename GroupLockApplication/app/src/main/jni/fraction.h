#ifndef FRACTION_H
#define FRACTION_H

class Fraction {
public:
    int c;
    int z;
    Fraction();
    Fraction(int x, int y);
    int NOD(int x, int y);
    int operator%(int mod);
	Fraction operator+(Fraction other);
	Fraction operator-(Fraction other);
	Fraction operator*(Fraction other);
    Fraction operator/(Fraction other);
};

#endif // FRACTION_H
