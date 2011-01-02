//
//  TestBezierPathView.m
//  TestBezierPath
//
//  Created by Waqar Malik on 3/13/10.
//  Copyright 2010 Crimson Research, Inc. All rights reserved.
//

#import "TestBezierPathView.h"
#import "CKBezierPath.h"

@implementation TestBezierPathView
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CKBezierPath *path = [CKBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 20.0f, 20.0f) cornerRadius:20.0f];
    [path appendPath:[CKBezierPath bezierPathWithOvalInRect:CGRectInset(rect, 30.0f, 30.0f)]];
    [path appendBezierPathWithRect:CGRectInset(rect, 60.0f, 40.0f)];
    path.lineWidth = 3.0f;
    path.usesEvenOddFillRule = NO;
    [[UIColor yellowColor] setFill];
    [[UIColor blueColor] setStroke];
    [path fill];
    [path stroke];
}
@end
