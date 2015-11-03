//
//  AppDelegate.h
//  HealthyFoodKitchen
//
//  Created by macmini5 on 24/08/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Google/SignIn.h>
#import "MFSideMenuContainerViewController.h"

CGFloat screenWidth;
CGFloat screenHeight;
BOOL isReach;
BOOL isFBlogin;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIStoryboard *storyBoard;
    UINavigationController *nav;
}
@property (strong, nonatomic) UIWindow *window;


@end

