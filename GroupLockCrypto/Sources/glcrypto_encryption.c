//
//  glcrypto_encryption.c
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 16.11.2016.
//
//

#include "glcrypto.h"

glcrypto_STATUS glcrypto_encrypt_file_in_location(const char                 * __nonnull  file_path,
                                                  glcrypto_KeyParameters                  key_parameters,
                                                  glcrypto_EncryptedData     * __nullable encrypted_data) {
    return GLCRYPTO_UNIMPLEMENTED;
}

glcrypto_STATUS glcrypto_encrypt_file_in_memory(const glcrypto_BYTE     * __nonnull  buffer,
                                                glcrypto_UINT                        size_of_buffer,
                                                glcrypto_KeyParameters               key_parameters,
                                                glcrypto_EncryptedData  * __nullable encrypted_data) {
    return GLCRYPTO_UNIMPLEMENTED;
}
