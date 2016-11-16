//
//  glcrypto.h
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 15.11.2016.
//
//

#ifndef glcrypto_h
#define glcrypto_h

#include "glcrypto_types.h"
#include "glcrypto_error.h"
#include "glcrypto_swift_interface.h"

/**
 Encrypts the file at the given path, puts the result into encrypted_data.

 @param file_path          The path of the file to encrypt.
 @param min_number_of_keys The minimum number of keys needed to decrypt the file.
 @param max_number_of_keys The overall number of keys.
 @param encrypted_data     The result of the encryption. In case of success it contains an encrypted
                           file and keys.

 @return GLCRYPTO_OK if encryption succeeded, otherwise an error code.
 */
glcrypto_status glcrypto_encrypt_file_in_location(const char                 * __nonnull  file_path,
                                                  glcrypto_uint                           min_number_of_keys,
                                                  glcrypto_uint                           max_number_of_keys,
                                                  glcrypto_encrypted_data    * __nullable encrypted_data)
GLCRYPTO_SWIFT_NAME(encrypt(filePath:minNumberOfKeys:maxNumberOfKeys:encryptedData:));

/**
 Encrypts a file in memory, puts the result into encrypted_data.

 @param buffer             The buffer that stores the file contents.
 @param size_of_buffer     The size of the buffer.
 @param min_number_of_keys The minimum number of keys needed to decrypt the file.
 @param max_number_of_keys The overall number of keys.
 @param encrypted_data     The result of the encryption. In case of success it contains an encrypted file and keys.

 @return GLCRYPTO_OK if encryption succeeded, otherwise an error code.
 */
glcrypto_status glcrypto_encrypt_file_in_memory(const glcrypto_byte     * __nonnull  buffer,
                                                glcrypto_uint                        size_of_buffer,
                                                glcrypto_uint                        min_number_of_keys,
                                                glcrypto_uint                        max_number_of_keys,
                                                glcrypto_encrypted_data * __nullable encrypted_data)
GLCRYPTO_SWIFT_NAME(encrypt(buffer:sizeOfBuffer:minNumberOfKeys:maxNumberOfKeys:encryptedData:));

/**
 Decrypts the file at the given path, puts the result into decrypted_data_buffer.

 @param file_path                  The path of the file to decrypt.
 @param keys                       An array of decryption keys.
 @param number_of_keys             The number of keys in the array.
 @param decrypted_data_buffer      The buffer that contains the decrypted file's bytes if decryption succeeded.
 @param decrypted_data_buffer_size The size of the buffer.

 @return GLCRYPTO_OK if decryption succeeded, otherwise an error code.
 */
glcrypto_status glcrypto_decrypt_file_in_location(const char     * __nonnull  file_path,
                                                  glcrypto_key   * __nonnull  keys,
                                                  glcrypto_uint               number_of_keys,
                                                  glcrypto_byte  * __nullable decrypted_data_buffer,
                                                  glcrypto_uint               decrypted_data_buffer_size)
GLCRYPTO_SWIFT_NAME(decrypt(filePath:keys:numberOfKeys:decryptedDataBuffer:decryptedDataBufferSize:));

/**
 Decrypts a file in memory puts the result into decrypted_data_buffer.

 @param buffer                     The buffer that stores the file contents.
 @param size_of_buffer             The size of the buffer.
 @param keys                       An array of decryption keys.
 @param number_of_keys             The number of keys in the array.
 @param decrypted_data_buffer      The buffer that contains the decrypted file's bytes if decryption succeeded.
 @param decrypted_data_buffer_size The size of the buffer.

 @return GLCRYPTO_OK if decryption succeeded, otherwise an error code.
 */
glcrypto_status glcrypto_decrypt_file_in_memory(const glcrypto_byte * __nonnull  buffer,
                                                glcrypto_uint                    size_of_buffer,
                                                glcrypto_key        * __nonnull  keys,
                                                glcrypto_uint                    number_of_keys,
                                                glcrypto_byte       * __nullable decrypted_data_buffer,
                                                glcrypto_uint                    decrypted_data_buffer_size)
GLCRYPTO_SWIFT_NAME(decrypt(buffer:sizeOfBuffer:keys:numberOfKeys:decryptedDataBuffer:decryptedDataBufferSize:));

#endif /* glcrypto_h */
