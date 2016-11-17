//
//  glcrypto_decryption.c
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 16.11.2016.
//
//

#include "glcrypto.h"

glcrypto_status glcrypto_decrypt_file_in_location(const char     * __nonnull  file_path,
                                                  glcrypto_key   * __nonnull  keys,
                                                  glcrypto_uint               number_of_keys,
                                                  glcrypto_byte  * __nullable decrypted_data_buffer,
                                                  glcrypto_uint               decrypted_data_buffer_size) {
    return GLCRYPTO_UNIMPLEMENTED;
}

glcrypto_status glcrypto_decrypt_file_in_memory(const glcrypto_byte * __nonnull  buffer,
                                                glcrypto_uint                    size_of_buffer,
                                                glcrypto_key        * __nonnull  keys,
                                                glcrypto_uint                    number_of_keys,
                                                glcrypto_byte       * __nullable decrypted_data_buffer,
                                                glcrypto_uint                    decrypted_data_buffer_size) {
    return GLCRYPTO_UNIMPLEMENTED;
}
