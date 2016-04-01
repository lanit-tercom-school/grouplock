/*
Class Fraction include operators: operator+, operator-, operator*, operator/, operator%, operator+=, operator-=,
operator*=, operator/=, operator= (Fraction) and operator= (const);
methods: ToString() for get HashCode
functions: NOD(x,y), reduce(c,z)
Ivanova Marina
March 2016.
*/

#pragma once

int NOD(int x, int y) {
	if (y == 0) {
		return x;
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
	int c;
	int z;
public:
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
		return std::to_string(c) + std::to_string(z);
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
	return (it.c == other.c && it.z == other.z ? true : false);
}

bool operator!=(const Fraction it, const Fraction other) {
	return !(it == other);
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



