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

int loadBMP(const char *fname, glcrypto_byte **map, glcrypto_byte **head);

void saveBMP(const char *indirect, const glcrypto_byte *map, const glcrypto_byte *head);

void encryptBMP(const char *fname, glcrypto_byte *nonce, glcrypto_byte *key);

void decryptBMP(const char *fname, glcrypto_byte *nonce, glcrypto_byte *key);

#endif /* glcrypto_bmp_h */
