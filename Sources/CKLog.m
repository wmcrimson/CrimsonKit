/*
 *  © Copyright Crimson Research, Inc. 2008. All rights reserved.
 */

#import "CKLog.h"

#ifdef DEBUG
void _CKLog(uint32_t line, const char *function, NSString *format, ...)
{
	va_list	args;
	va_start(args, format);
	NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
	va_end(args);
	
	NSLog(@"%u %s: %@", line, function, message);
	[message release];
}
#endif
