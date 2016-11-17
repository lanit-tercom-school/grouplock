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
# include <CoreFoundation/CFBase.h>
# define GLCRYPTO_SWIFT_NAME(name) CF_SWIFT_NAME(name)
#elif
# define GLCRYPTO_SWIFT_NAME(name)
#endif

#endif /* glcrypto_swift_interface_h */
