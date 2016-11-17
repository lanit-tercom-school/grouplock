//
//  bmp_tests.c
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 16.11.2016.
//
//

#include "utils.h"
#include "suites.h"
#include "glcrypto.h"

SET_UP() {
    // Put setup code here. This method is called before the invocation
    // of each test function in this suite.
}

TEAR_DOWN() {
    // Put teardown code here. This method is called after the invocation
    // of each test function in this suite.
}

TEST(example) {
    CU_ASSERT(1);
}

SUITE(bmp_tests) {
    
    ADD_SUITE(bmp_tests);
    ADD_TEST_TO_CURRENT_SUITE(example);
    
    return 0;
}
