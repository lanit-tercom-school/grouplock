/* UnitTests for lib fraction.h
Ivanova Mrina March 2016*/
#include "stdafx.h"
#include "CppUnitTest.h"
#include  "fraction.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace TestFraction
{		

	TEST_CLASS(UnitTest1)
	{
	public:
		
		TEST_METHOD(nod) {
			Fraction a, b, o;
			Assert::AreEqual(a.NOD(25,5), 5);
		}

		TEST_METHOD(mod) {
			Fraction a, b, o;
			a.c = -1;
			a.z = 2;
			Assert::AreEqual(a.operator%(23), 11);
		}

		TEST_METHOD(difference) {
			Fraction a, b, o;
			a.c = 10;
			a.z = 3;
			b.c = 6;
			b.z = 2;
			o.c = 1;
			o.z = 3;
			Assert::AreEqual((a - b).c, o.c);
			Assert::AreEqual((a - b).z, o.z);
		}

		TEST_METHOD(sum) {
			Fraction a, b, o;
			a.c = 5;
			a.z = 2;
			b.c = 5;
			b.z = 2;
			o.c = 5;
			o.z = 1;
			Assert::AreEqual((a+b).c, o.c);
			Assert::AreEqual((a + b).z, o.z);
		}

		TEST_METHOD(mult) {
			Fraction a, b, o;
			a.c = 2;
			a.z = 3;
			b.c = 5;
			b.z = 2;
			o.c = 5;
			o.z = 3;
			Assert::AreEqual((a * b).c, o.c);
			Assert::AreEqual((a * b).z, o.z);
		}

		TEST_METHOD(div) {
			Fraction a, b, o;
			a.c = 10;
			a.z = 2;
			b.c = 5;
			b.z = 1;
			o.c = 1;
			o.z = 1;
			Assert::AreEqual((a / b).c, o.c);
			Assert::AreEqual((a / b).z, o.z);
		}
	};
}