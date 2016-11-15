//
//  decryptBMP.h
//  glcrypto
//
//  Created by Kirill Solntsev.
//

#ifndef decryptBMP_h
#define decryptBMP_h

#include "sodium.h"

void decryptBMP(const char *fname,
                unsigned char nonce[crypto_secretbox_NONCEBYTES],
                unsigned char key[crypto_secretbox_KEYBYTES]);

#endif /* decryptBMP_h */
