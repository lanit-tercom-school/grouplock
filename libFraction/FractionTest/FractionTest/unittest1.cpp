/* UnitTests for lib fraction.h
Ivanova Marina.
March 2016.
*/
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
			Assert::AreEqual(NOD(25, 5), 5);
		}

		TEST_METHOD(mod) {
			Fraction a(-1, 2);
			Assert::AreEqual(a % (23), 11);
		}

		TEST_METHOD(difference) {
			Fraction a(10, 3);
			Fraction b(6, 2);
			Fraction o(1, 3);
	    	Assert::AreEqual(std::string((a - b).ToString()), std::string(o.ToString()));
			Assert::AreEqual(std::string((a -= b).ToString()), std::string(o.ToString()));
		}

		TEST_METHOD(sum) {
			Fraction a(5, 2);
			Fraction b(5, 2);
			Fraction o(5, 1);
			Assert::AreEqual(std::string((a + b).ToString()), std::string(o.ToString()));
			Assert::AreEqual(std::string((a += b).ToString()), std::string(o.ToString()));
		}

		TEST_METHOD(mult) {
			Fraction a(2, 3);
			Fraction b(5, 2);
			Fraction o(5, 3);
			Assert::AreEqual(std::string((a * b).ToString()), std::string(o.ToString()));
			Assert::AreEqual(std::string((a *= b).ToString()), std::string(o.ToString()));
		}

		TEST_METHOD(div) {
			Fraction a(10, 2);
			Fraction b(5, 1);
			Fraction o(1, 1);
			Assert::AreEqual(std::string((a / b).ToString()), std::string(o.ToString()));
			Assert::AreEqual(std::string((a /= b).ToString()), std::string(o.ToString()));
		}

		TEST_METHOD(equals) {
			Fraction a(-2, 2);
			Fraction b(-2, 2);
			Assert::AreEqual(a==b, true);
			Assert::AreEqual(a != b, false);
		}

		TEST_METHOD(assignment){
			Fraction a(2, 2);
			Fraction b(3, 5);
			Fraction o(3, 5);
			a = 0;
		//	Assert::AreEqual(std::string((a = b).ToString()), std::string(o.ToString()));
			Assert::AreEqual(std::string((a).ToString()), std::string(Fraction(0,1).ToString()));
		}
	};
}