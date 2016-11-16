//
//  glcrypto_encryption.c
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 16.11.2016.
//
//

#include "glcrypto.h"

glcrypto_status glcrypto_encrypt_file_in_location(const char                 * __nonnull  file_path,
                                                  glcrypto_uint                           min_number_of_keys,
                                                  glcrypto_uint                           max_number_of_keys,
                                                  glcrypto_encrypted_data    * __nullable encrypted_data) {
    return GLCRYPTO_UNIMPLEMENTED;
}

glcrypto_status glcrypto_encrypt_file_in_memory(const glcrypto_byte     * __nonnull  buffer,
                                                glcrypto_uint                        size_of_buffer,
                                                glcrypto_uint                        min_number_of_keys,
                                                glcrypto_uint                        max_number_of_keys,
                                                glcrypto_encrypted_data * __nullable encrypted_data) {
    return GLCRYPTO_UNIMPLEMENTED;
}
