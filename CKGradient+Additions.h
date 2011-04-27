//
//  CKGradient+Additions.h
//  CrimsonKit
//
//  Created by Waqar Malik on 2/7/10.
//  © Copyright 2008 Crimson Research, Inc. All rights reserved.
//

#import "CKGradient.h"

@interface CKGradient (Common)
+ (CKGradient *)aquaSelectedGradient NS_RETURNS_NOT_RETAINED;
+ (CKGradient *)aquaNormalGradient NS_RETURNS_NOT_RETAINED;
+ (CKGradient *)aquaPressedGradient NS_RETURNS_NOT_RETAINED;

+ (CKGradient *)unifiedSelectedGradient NS_RETURNS_NOT_RETAINED;
+ (CKGradient *)unifiedNormalGradient NS_RETURNS_NOT_RETAINED;
+ (CKGradient *)unifiedPressedGradient NS_RETURNS_NOT_RETAINED;
+ (CKGradient *)unifiedDarkGradient NS_RETURNS_NOT_RETAINED;

+ (CKGradient *)sourceListSelectedGradient NS_RETURNS_NOT_RETAINED;
+ (CKGradient *)sourceListUnselectedGradient NS_RETURNS_NOT_RETAINED;
@end
