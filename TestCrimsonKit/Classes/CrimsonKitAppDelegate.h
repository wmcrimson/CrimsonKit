//
//  CrimsonKitAppDelegate.h
//  CrimsonKit
//
//  Created by Waqar Malik on 6/24/10.
//  Copyright Crimson Research, Inc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrimsonKitAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
