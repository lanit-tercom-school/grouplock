//
//  glcrypto_types.h
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 16.11.2016.
//
//

#ifndef glcrypto_types_h
#define glcrypto_types_h

typedef unsigned char   glcrypto_byte;
typedef unsigned long   glcrypto_status;
typedef unsigned int    glcrypto_uint;
typedef void            glcrypto_key;    // FIXME: Replace void for the type that will be used for storing keys

typedef struct glcrypto_encrypted_data {
    glcrypto_byte *buffer;
    glcrypto_key  *key;
    glcrypto_uint buffer_size;
    glcrypto_uint number_of_keys;
} glcrypto_encrypted_data;

#endif /* glcrypto_types_h */
