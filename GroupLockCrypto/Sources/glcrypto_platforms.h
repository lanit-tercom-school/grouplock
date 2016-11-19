//
//  glcrypto_swift_interface.h
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 16.11.2016.
//
//

#ifndef glcrypto_swift_interface_h
#define glcrypto_swift_interface_h

#if defined(__APPLE__)
#  include <CoreFoundation/CFBase.h>
#  define GLCRYPTO_SWIFT_NAME(name) CF_SWIFT_NAME(name)
#else
#  define GLCRYPTO_SWIFT_NAME(name)
#endif


// Pointer nullability can be specified differently depending on the compiler used.
// Here we support Clang and GCC compilers.
#if defined(__clang__)
#  define GLCRYPTO_NONNULL_ARGUMENTS(...)
#elif defined(__GNUC__)
#  undef  __nonnull
#  define __nonnull
#  undef  __nullable
#  define __nullable
#  define GLCRYPTO_NONNULL_ARGUMENTS(...) __attribute__((nonnull (__VA_ARGS__)))
#else
#  ifdef __nonnull
#    undef __nonnull
#    define __nonnull
#  endif
#  ifdef __nullable
#    undef __nullable
#    define __nullable
#  endif
#  define GLCRYPTO_NONNULL_ARGUMENTS(...)
#endif

#endif /* glcrypto_swift_interface_h */
