//
//  bmp_tests.c
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 16.11.2016.
//
//

#include "utils.h"
#include "suites.h"

#include "sodium.h"
#include "glcrypto.h"
#include "glcrypto_bmp.h"

#define LENA_PATH           "resources/lena.bmp"
#define ENCRYPTED_LENA_PATH "resources/encrypted_lena.bmp"
#define DECRYPTED_LENA_PATH "resources/decrypted_lena.bmp"

SET_UP() {
    // Put setup code here. This method is called before the invocation
    // of each test function in this suite.
}

TEAR_DOWN() {
    // Put teardown code here. This method is called after the invocation
    // of each test function in this suite.
}

TEST(encrypt_and_decrypt_bmp) {
    
    unsigned char nonce[crypto_secretbox_NONCEBYTES];
    unsigned char key[crypto_secretbox_KEYBYTES];
    
    encryptBMP(LENA_PATH, nonce, key);
    
    decryptBMP(ENCRYPTED_LENA_PATH, nonce, key);
    
    CU_ASSERT(compare_files_at_paths(LENA_PATH, DECRYPTED_LENA_PATH));
}

SUITE(bmp_tests) {
    
    ADD_SUITE(bmp_tests);
    ADD_TEST_TO_CURRENT_SUITE(encrypt_and_decrypt_bmp);
    
    return 0;
}
