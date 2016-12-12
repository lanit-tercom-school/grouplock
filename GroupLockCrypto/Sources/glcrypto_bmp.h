//
//  glcrypto_bmp.h
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 16.11.2016.
//
//

#ifndef glcrypto_bmp_h
#define glcrypto_bmp_h

#include "glcrypto_types.h"

int loadBMP(const char *fname, glcrypto_BYTE **map, glcrypto_BYTE **head);

void saveBMP(const char *indirect, const glcrypto_BYTE *map, const glcrypto_BYTE *head);

void encryptBMP(const char *fname, glcrypto_BYTE *nonce, glcrypto_BYTE *key);

void decryptBMP(const char *fname, glcrypto_BYTE *nonce, glcrypto_BYTE *key);

#endif /* glcrypto_bmp_h */
