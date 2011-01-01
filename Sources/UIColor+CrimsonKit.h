//
//  UIColor+Crimson.h
//  CrimsonKit
//
//  Created by Waqar Malik on 12/31/10.
//  Copyright 2010 Crimson Research, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CrimsonKit)
+ (UIColor *)colorWithRGBAString:(NSString *)colorString;
+ (UIColor *)colorWithRGBAHex:(uint32_t)colorValue;
@end
