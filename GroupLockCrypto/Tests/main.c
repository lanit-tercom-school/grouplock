//
//  main.c
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 16.11.2016.
//
//

#include "utils.h"
#include "suites.h"

int main() {
    
    INITIALIZE_CUNIT();
    
    // Add here statements like PREPARE_SUITE(suite_name); for all your suites
    PREPARE_SUITE(bmp_tests);
    
    RUN_TESTS();
    
    return 0;
}
