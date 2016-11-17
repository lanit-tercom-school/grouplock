//
//  utils.c
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 17.11.2016.
//
//

#include <stdio.h>
#include "utils.h"

CU_pSuite create_test_suite(const char* title) {

    CU_pSuite suite;
    
    suite = CU_add_suite(title, NULL, NULL);
    
    if (suite == NULL) {
        fprintf(stderr, "%s\n", CU_get_error_msg());
        CU_cleanup_registry();
        return NULL;
    }
    
    return suite;
}
