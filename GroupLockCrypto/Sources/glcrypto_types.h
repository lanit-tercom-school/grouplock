//
//  glcrypto_types.h
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 16.11.2016.
//
//

#ifndef glcrypto_types_h
#define glcrypto_types_h

#include "glcrypto_swift_interface.h"

typedef unsigned char   glcrypto_BYTE                           GLCRYPTO_SWIFT_NAME(Byte);

typedef unsigned long   glcrypto_STATUS                         GLCRYPTO_SWIFT_NAME(Status);

typedef unsigned int    glcrypto_UINT                           GLCRYPTO_SWIFT_NAME(UInt);

// FIXME: Replace void for the type that will be used for storing keys
typedef void            glcrypto_KEY                            GLCRYPTO_SWIFT_NAME(Key);

typedef struct _glcrypto_EncryptedData glcrypto_EncryptedData   GLCRYPTO_SWIFT_NAME(EncryptedData);

struct _glcrypto_EncryptedData {
    glcrypto_BYTE * __nonnull buffer;
    glcrypto_KEY  * __nonnull key;
    glcrypto_UINT buffer_size           GLCRYPTO_SWIFT_NAME(bufferSize);
    glcrypto_UINT number_of_keys        GLCRYPTO_SWIFT_NAME(numberOfKeys);
};

typedef struct _glcrypto_KeyParameters glcrypto_KeyParameters   GLCRYPTO_SWIFT_NAME(KeyParameters);

struct _glcrypto_KeyParameters  {
    glcrypto_UINT min_number_of_keys    GLCRYPTO_SWIFT_NAME(minNumberOfKeys);
    glcrypto_UINT max_number_of_keys    GLCRYPTO_SWIFT_NAME(maxNumberOfKeys);
};

#endif /* glcrypto_types_h */
