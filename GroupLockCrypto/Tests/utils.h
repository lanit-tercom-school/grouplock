//
//  utils.h
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 17.11.2016.
//
//

#ifndef utils_h
#define utils_h

#include <stdio.h>
#include "CUnit/Basic.h"

#define TEST(name) static void test_##name()

#define SET_UP() static void set_up()
#define TEAR_DOWN() static void tear_down()

#define ADD_TEST_TO_CURRENT_SUITE(test_name) \
if ((NULL == CU_add_test(suite, #test_name, (CU_TestFunc)test_##test_name))) {\
    fprintf(stderr, "%s", CU_get_error_msg());\
    CU_cleanup_registry();\
    return CU_get_error();\
}\

#define ADD_SUITE(name)\
CU_pSuite suite = NULL;\
suite = CU_add_suite_with_setup_and_teardown(#name, NULL, NULL, set_up, tear_down);\
if (NULL == suite) {\
    CU_cleanup_registry();\
    fprintf(stderr, "%s", CU_get_error_msg());\
    return CU_get_error();\
}\

#define INITIALIZE_CUNIT() {\
    if (CUE_SUCCESS != CU_initialize_registry()) {\
        fprintf(stderr, "%s", CU_get_error_msg());\
        return CU_get_error();\
    }\
}\

#define PREPARE_SUITE(name) name##_prepare()
#define SUITE(name) int PREPARE_SUITE(name)

#define RUN_TESTS() {\
    CU_basic_set_mode(CU_BRM_VERBOSE);\
    CU_basic_run_tests();\
    if (CU_get_number_of_tests_failed() != 0) {\
        CU_cleanup_registry();\
        return 1;\
    }\
    CU_cleanup_registry();\
}\

/**
 Compares the two files bytewise.

 @param file1 The first file.
 @param file2 The second file.
 @return CU_TRUE if the files are equal or both are NULL, otherwise CU_FALSE.
 */
CU_BOOL compare_files(FILE *file1, FILE *file2);

/**
 Compares the two files at the given paths bytewise.

 @param file_path1 The path to the first file.
 @param file_path2 The path to the second file.
 @return CU_TRUE if the files are equal, CU_FALSE if they are not equal or could not be opened.
 */
CU_BOOL compare_files_at_paths(const char *file_path1, const char *file_path2);

#endif /* utils_h */
