/*
 *  © Copyright Crimson Research, Inc. 2008. All rights reserved.
 */


#ifndef __CKLOG_H__
#define __CKLOG_H__

#import "CKSourceAnnotations.h"

#ifdef __cplusplus
extern "C" {
#endif
    
#ifdef DEBUG
    void _CKLog(uint32_t line, const char *function, NSString *format, ...) __attribute__((nonnull(2,3)));
#endif
    
#ifdef DEBUG
#define CKLog(x, ...)  _CKLog(__LINE__, __FUNCTION__, x, ##__VA_ARGS__);
#else
#define CKLog(x, ...)
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CKLOG_H__ */
