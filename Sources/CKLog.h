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
    void _CKLogDebug(const char *file, const char *function, uint32_t line, NSString *format, ...) __attribute__((nonnull(1,2,4)));
#endif
    
#ifdef DEBUG
#define CKLog(x, ...)  _CKLogDebug(__FILE__, __FUNCTION__, __LINE__, x, ##__VA_ARGS__);
#else
#define CKLog(x, ...)
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CKLOG_H__ */
