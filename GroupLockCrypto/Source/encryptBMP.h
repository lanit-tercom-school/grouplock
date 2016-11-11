//
//  encryptBMP.h
//  glcrypto
//
//  Created by Kirill Solntsev.
//

#ifndef encryptBMP_h
#define encryptBMP_h

#include "sodium.h"

void encryptBMP(const char *fname,
                unsigned char nonce[crypto_secretbox_NONCEBYTES],
                unsigned char key[crypto_secretbox_KEYBYTES]);

#endif /* encryptBMP_h */
