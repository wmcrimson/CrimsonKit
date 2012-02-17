/*
 *  © Copyright Crimson Research, Inc. 2008. All rights reserved.
 */

#import "CKLog.h"

#ifdef DEBUG
void _CKLogDebug(const char *file, const char *function, uint32_t line, NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    __strong NSString *logMessage = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    static NSDateFormatter *sCKDebugFormatter = nil;
    if(nil == sCKDebugFormatter)
    {
        sCKDebugFormatter = [[NSDateFormatter alloc] init];
        [sCKDebugFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSString *timeStamp = [sCKDebugFormatter stringFromDate:[NSDate date]];
    NSString *filePath = [NSString stringWithCString:file encoding:NSUTF8StringEncoding];

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    fprintf(stdout, "%s %s %s %s:%d %s\n",
            [timeStamp UTF8String],
            [[infoDict objectForKey:(NSString *)kCFBundleNameKey] UTF8String],
            [[filePath lastPathComponent] UTF8String],
            function,
            line,
            [logMessage UTF8String]);
}
#endif
