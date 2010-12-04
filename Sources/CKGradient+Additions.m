//
//  CKGradient+Additions.h
//  CrimsonKit
//
//  Created by Waqar Malik on 2/7/10.
//  © Copyright 2008 Crimson Research, Inc. All rights reserved.
//
//  $Id: CKGradient+Additions.m 92 2010-06-08 22:19:23Z malik $
//

#import "CKGradient+Additions.h"

@implementation CKGradient (Common)
+ (CKGradient *)aquaSelectedGradient
{
	NSArray *colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:0.58f green:0.86f blue:0.98f alpha:1.00f],
						   [UIColor colorWithRed:0.42f green:0.68f blue:0.68f alpha:1.00f],
						   [UIColor colorWithRed:0.64f green:0.80f blue:0.94f alpha:1.00f],
						   [UIColor colorWithRed:0.56f green:0.70f blue:0.90f alpha:1.00f], nil];
	const CGFloat locations[4] = {0.00f, 11.5f/23.0f, 11.5f/23.0f, 1.00f};
	return [[[[self class] alloc] initWithColors:colorArray atLocations:locations colorSpace:NULL] autorelease];
}

+ (CKGradient *)aquaNormalGradient
{
	NSArray *colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f],
						   [UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f],
						   [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f],
						   [UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.00f], nil];
	const CGFloat locations[4] = {0.00f, 11.5f/23.0f, 11.5f/23.0f, 1.00f};
	return [[[[self class] alloc] initWithColors:colorArray atLocations:locations colorSpace:NULL] autorelease];
}

+ (CKGradient *)aquaPressedGradient
{
	NSArray *colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f],
						   [UIColor colorWithRed:0.64f green:0.64f blue:0.64f alpha:1.00f],
						   [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f],
						   [UIColor colorWithRed:0.77f green:0.77f blue:0.77f alpha:1.00f], nil];
	const CGFloat locations[4] = {0.00f, 11.5f/23.0f, 11.5f/23.0f, 1.00f};
	return [[[[self class] alloc] initWithColors:colorArray atLocations:locations colorSpace:NULL] autorelease];
}

+ (CKGradient *)unifiedSelectedGradient
{
	return [[[[self class] alloc] initWithStartingColor:[UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.0f]
											endingColor:[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f]] autorelease];
}

+ (CKGradient *)unifiedNormalGradient
{
	return [[[[self class] alloc] initWithStartingColor:[UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.0f]
											endingColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.0f]] autorelease];
}

+ (CKGradient *)unifiedPressedGradient
{
	return [[[[self class] alloc] initWithStartingColor:[UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.0f]
											endingColor:[UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.0f]] autorelease];
}

+ (CKGradient *)unifiedDarkGradient
{
	return [[[[self class] alloc] initWithStartingColor:[UIColor colorWithRed:0.68f green:0.68f blue:0.68f alpha:1.0f]
											endingColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.0f]] autorelease];
}

+ (CKGradient *)sourceListSelectedGradient
{
	return [[[[self class] alloc] initWithStartingColor:[UIColor colorWithRed:0.06f green:0.37f blue:0.85f alpha:1.0f]
											endingColor:[UIColor colorWithRed:0.30f green:0.60f blue:0.92f alpha:1.0f]] autorelease];
}

+ (CKGradient *)sourceListUnselectedGradient
{
	return [[[[self class] alloc] initWithStartingColor:[UIColor colorWithRed:0.43f green:0.43f blue:0.43f alpha:1.0f]
											endingColor:[UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.0f]] autorelease];
}
@end
