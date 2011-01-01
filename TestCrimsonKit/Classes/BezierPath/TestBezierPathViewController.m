//
//  TestBezierPathViewController.m
//  TestBezierPath
//
//  Created by Waqar Malik on 3/13/10.
//  Copyright Crimson Research, Inc. 2010. All rights reserved.
//

#import "TestBezierPathViewController.h"
#import "UIColor+CrimsonKit.h"

@implementation TestBezierPathViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    NSLog(@"Blue Color hex string = %@", [UIColor blueColor].RGBAString);
}
@end
