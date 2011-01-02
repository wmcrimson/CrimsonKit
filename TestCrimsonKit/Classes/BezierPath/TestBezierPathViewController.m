//
//  TestBezierPathViewController.m
//  TestBezierPath
//
//  Created by Waqar Malik on 3/13/10.
//  Copyright Crimson Research, Inc. 2010. All rights reserved.
//

#import "TestBezierPathViewController.h"
#import "UIColor+CrimsonKit.h"
#import "CKLog.h"

@implementation TestBezierPathViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    CKLog(@"Blue Color hex string = %@", [UIColor blueColor].RGBAString);
}
@end
