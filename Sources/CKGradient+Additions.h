//
//  CKGradient+Additions.h
//  CrimsonKit
//
//  Created by Waqar Malik on 2/7/10.
//  © Copyright 2008 Crimson Research, Inc. All rights reserved.
//
//  $Id: CKGradient+Additions.h 96 2010-06-24 22:15:49Z malik $
//

#import "CKGradient.h"

@interface CKGradient (Common)
+ (CKGradient *)aquaSelectedGradient;
+ (CKGradient *)aquaNormalGradient;
+ (CKGradient *)aquaPressedGradient;

+ (CKGradient *)unifiedSelectedGradient;
+ (CKGradient *)unifiedNormalGradient;
+ (CKGradient *)unifiedPressedGradient;
+ (CKGradient *)unifiedDarkGradient;

+ (CKGradient *)sourceListSelectedGradient;
+ (CKGradient *)sourceListUnselectedGradient;
@end
