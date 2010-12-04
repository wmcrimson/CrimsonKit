//
//  TestCKGradientView.m
//  TestCKGradient
//
//  Created by Waqar Malik on 3/19/10.
//  Copyright 2010 Crimson Research, Inc. All rights reserved.
//

#import "TestGradientView.h"
#import "CKGradient.h"
#import "CKBezierPath.h"

@implementation TestGradientView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CKGradient *gradient = [[CKGradient alloc] initWithStartingColor:[UIColor blueColor] endingColor:[UIColor yellowColor]];
    [gradient drawInRect:rect angle:45.0f];
    [gradient release];
    
    CKBezierPath *path = [CKBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 10, 20) cornerRadius:30];
    gradient = [[CKGradient alloc] initWithStartingColor:[UIColor greenColor] endingColor:[UIColor redColor]];
    [gradient drawInBezierPath:path angle:0];
    [gradient release];
 
    path = [CKBezierPath bezierPathWithOvalInRect:CGRectInset(rect, 30, 80)];
    gradient = [[CKGradient alloc] initWithStartingColor:[UIColor cyanColor] endingColor:[UIColor magentaColor]];
    [gradient drawInBezierPath:path angle:180];
    [gradient release];
    CGRect myRect = CGRectInset(rect, 40, 110);
    path = [CKBezierPath bezierPathWithOvalInRect:myRect];
    [path appendPath:[CKBezierPath bezierPathWithOvalInRect:CGRectInset(myRect, 20, 20)]];
    path.usesEvenOddFillRule = YES;
    [path addClip];
    gradient = [[CKGradient alloc] initWithStartingColor:[UIColor orangeColor] endingColor:[UIColor purpleColor]];
    [gradient drawFromPoint:CGPointMake(CGRectGetMinX(myRect), CGRectGetMinY(myRect)) toPoint:CGPointMake(CGRectGetMinX(myRect), CGRectGetMaxY(myRect)) options:0];
    [gradient release];
}

- (void)dealloc
{
    [super dealloc];
}
@end
