/*
 *  © Copyright Crimson Research, Inc. 2008. All rights reserved.
 */


#import "CKSourceAnnotations.h"

#ifdef DEBUG
void _CKLog(uint32_t line, const char *function, NSString *format, ...) __attribute__((nonnull(2,3)));
#endif

#ifdef DEBUG
#define CKLog(x, ...)  _CKLog(__LINE__, __FUNCTION__, x, ##__VA_ARGS__);
#else
#define CKLog(x, ...)
#endif
