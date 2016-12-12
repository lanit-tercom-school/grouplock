//
//  glcrypto_decryption.c
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 16.11.2016.
//
//

#include "glcrypto.h"

glcrypto_STATUS glcrypto_decrypt_file_in_location(const char     * __nonnull  file_path,
                                                  glcrypto_KEY   * __nonnull  keys,
                                                  glcrypto_UINT               number_of_keys,
                                                  glcrypto_BYTE  * __nullable decrypted_data_buffer,
                                                  glcrypto_UINT               decrypted_data_buffer_size) {
    return GLCRYPTO_UNIMPLEMENTED;
}

glcrypto_STATUS glcrypto_decrypt_file_in_memory(const glcrypto_BYTE * __nonnull  buffer,
                                                glcrypto_UINT                    size_of_buffer,
                                                glcrypto_KEY        * __nonnull  keys,
                                                glcrypto_UINT                    number_of_keys,
                                                glcrypto_BYTE       * __nullable decrypted_data_buffer,
                                                glcrypto_UINT                    decrypted_data_buffer_size) {
    return GLCRYPTO_UNIMPLEMENTED;
}
