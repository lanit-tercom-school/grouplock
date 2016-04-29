/*
Class Fraction include operators: operator+, operator-, operator*, operator/, operator%, operator+=, operator-=,
operator*=, operator/=, operator= (Fraction) and operator= (const);
methods: ToString() for get HashCode
functions: NOD(x,y), reduce(c,z)
Ivanova Marina
March 2016.
*/

#pragma once
#include<math.h>
#include <string>
int NOD(int x, int y) {
	if (y == 0) {
		return abs(x);
	}
	else {
		return NOD(y, x % y);
	}
}

//ћетод дл€ сокращени€ дроби
void reduce(int& c, int& z) {
	int nod = NOD(c, z);
	c /= nod;
	z /= nod;
}

class Fraction {
public:
	int c;
	int z;

	Fraction() {};
	Fraction(int x, int y) : c(x), z(y) {};

	friend int operator%(const Fraction it, int nod);
	friend bool operator==(const Fraction it, const Fraction other);

	Fraction& operator-=(const Fraction other) {
		c = c*other.z - other.c*z;
		z = z*other.z;
		reduce(c, z);
		return *this;
	}

	Fraction& operator+=(const Fraction other) {
		c = c*other.z + other.c*z;
		z = z*other.z;
		reduce(c, z);
		return *this;
	}

	Fraction& operator*=(const Fraction other) {
		c = c*other.c;
		z = z*other.z;
		reduce(c, z);
		return *this;
	}

	Fraction& operator/=(const Fraction other) {
		c = c*other.z;
		z = z*other.c;
		reduce(c, z);
		return *this;
	}

	// метод дл€ получени€ хешкода дроби в виде строки: значение C значение Z
	std::string ToString() {
		int sing = (c*z < 0 ? -1 : 1);
		return std::to_string(sing) + std::to_string(abs(c)) + std::to_string(abs(z));
	}

	Fraction& operator=(const Fraction& frac) {
		c = frac.c;
		z = frac.z;
		return *this;
	}

	Fraction& operator=(const int constanta) {
		c = constanta;
		z = 1;
		return *this;
	}
};

bool operator==(const Fraction it, const Fraction other) {
	return (abs(it.c) == abs(other.c) && abs(it.z) == abs(other.z) && it.c*it.z == other.c*other.z ? true : false);
}

bool operator!=(const Fraction it, const Fraction other) {
	return !(it == other);
}
bool operator>(const Fraction it, const Fraction other) {
	return (it.c * other.z > other.c*it.z ? true : false);
}

bool operator<(const Fraction it, const Fraction other) {
	return (it.c * other.z < other.c*it.z ? true : false);
}

bool operator>=(const Fraction it, const Fraction other) {
	return (!(it<other) ? true : false);
}
bool operator<=(const Fraction it, const Fraction other) {
	return (!(it>other) ? true : false);
}

int operator%(const Fraction it, int mod) {
	Fraction A = it;
	if (A.c == mod) {
		return 0;
	}
	while (NOD(A.c, A.z) != A.z) {
		A.c = A.c + mod;
	}
	return A.c / A.z;
}

Fraction operator-(const Fraction it, const Fraction other) {
	Fraction s = it;
	s -= other;
	return s;
}

Fraction operator+(const Fraction it, const Fraction other) {
	Fraction s = it;
	s += other;
	return s;
}

Fraction operator*(const Fraction it, const Fraction other) {
	Fraction s = it;
	s *= other;
	return s;
}

Fraction operator/(const Fraction it, const Fraction other) {
	Fraction s = it;
	s /= other;
	return s;
}



