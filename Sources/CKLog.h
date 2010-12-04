/*
 *  © Copyright Crimson Research, Inc. 2008. All rights reserved.
 *
 *  $Id: CKLog.h 104 2010-07-10 19:05:47Z malik $
 */

#ifdef DEBUG
void _CKLog(uint32_t line, const char *function, NSString *format, ...);
#endif

#ifdef DEBUG
#define CKLog(x, ...)  _CKLog(__LINE__, __FUNCTION__, x, ##__VA_ARGS__);
#else
#define CKLog(x, ...)
#endif
