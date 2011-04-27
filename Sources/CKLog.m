/*
 *  © Copyright Crimson Research, Inc. 2008. All rights reserved.
 */

#import "CKLog.h"

#ifdef DEBUG
void _CKLogDebug(const char *file, const char *function, uint32_t line, NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    NSString *logmsg = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    static NSDateFormatter *gCKDebugFormatter = nil;
    if(nil == gCKDebugFormatter)
    {
        gCKDebugFormatter = [[NSDateFormatter alloc] init];
        [gCKDebugFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSString *timestamp = [gCKDebugFormatter stringFromDate:[NSDate date]];
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    fprintf(stdout, "%s %s %s:%d %s\n",
            [timestamp UTF8String],
            [[infoDict objectForKey:(NSString *)kCFBundleNameKey] UTF8String],
            function,
            line,
            [logmsg UTF8String]);
    [logmsg release];
}
#endif
