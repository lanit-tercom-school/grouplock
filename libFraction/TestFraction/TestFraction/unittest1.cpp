// UnitTests for lib fraction.h
#include "stdafx.h"
#include "CppUnitTest.h"
#include  "fraction.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace TestFraction
{		

	TEST_CLASS(UnitTest1)
	{
	public:
		Fraction a, b, o;
		
		TEST_METHOD(nod) {
			Assert::AreEqual(a.NOD(25,5), 5);
		}
		TEST_METHOD(mod) {
			a.c = -1;
			a.z = 2;
			Assert::AreEqual(a.operator%(23), 11);
		}
		TEST_METHOD(difference) {
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