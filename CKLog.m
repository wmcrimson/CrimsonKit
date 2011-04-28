/*
 *  © Copyright Crimson Research, Inc. 2008. All rights reserved.
 */

#import "CKLog.h"

#ifdef DEBUG
void _CKLogDebug(const char *file, const char *function, uint32_t line, NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    NSString *logMessage = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    static NSDateFormatter *gCKDebugFormatter = nil;
    if(nil == gCKDebugFormatter)
    {
        gCKDebugFormatter = [[NSDateFormatter alloc] init];
        [gCKDebugFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSString *timeStamp = [gCKDebugFormatter stringFromDate:[NSDate date]];
    NSString *filePath = [[NSString alloc] initWithUTF8String:file];    

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    fprintf(stdout, "%s %s %s %s:%d %s\n",
            [timeStamp UTF8String],
            [[infoDict objectForKey:(NSString *)kCFBundleNameKey] UTF8String],
            [[filePath lastPathComponent] UTF8String],
            function,
            line,
            [logMessage UTF8String]);
    [logMessage release], logMessage = nil;
    [filePath release], filePath = nil;
}
#endif
