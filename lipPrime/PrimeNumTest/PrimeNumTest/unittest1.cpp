#include "stdafx.h"
#include "CppUnitTest.h"
#include "PrimeNum.h"
using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace TestPrimeNum
{
	TEST_CLASS(UnitTest1)
	{
	public:

		TEST_METHOD(pow) {
			Assert::AreEqual(PrimeNum::pow(3), 1000);
		}
		TEST_METHOD(choice_primeNum)
		{
			Assert::AreEqual(PrimeNum::choice_PrimeNum(2, 2), 11);
			// TODO: Разместите здесь код своего теста
		}

	};
}