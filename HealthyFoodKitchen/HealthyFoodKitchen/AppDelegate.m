//
//  AppDelegate.m
//  HealthyFoodKitchen
//
//  Created by macmini5 on 24/08/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "Helper.h"
#import "LoginVC.h"
#import "Common.h"
#import "HomeVC.h"
#import "TermsOfServiceVC.h"
#import "TellUSWhatYouLoveVC.h"
@interface AppDelegate ()

@end

static NSString * const kClientID =
@"641575471410-ftvnti650dtg29sdk4n8uac2dpehf2i2.apps.googleusercontent.com";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    selectedIndex = 0;
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"login"] == nil){
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"login"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    Reachability * reach = [Reachability reachabilityWithHostName:@"www.google.com"];
    [reach startNotifier];

    /*===LOGIN WITH GOOGLE===*/
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    /*===SIDE MENU CONFIGURATION===*/
    
    storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];//Main
    
    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController *)self.window.rootViewController;
    nav = [storyBoard instantiateViewControllerWithIdentifier:@"navigationController"];
    
    int login = (int)[Helper getNsuserValue:KLoggedIN];
    int terms = (int)[Helper getNsuserValue:KTOSAccepted];
    int tell =  (int)[Helper getNsuserValue:KTOSAccepted];
    if(login == 0){
        LoginVC *LoginVC=[storyBoard instantiateViewControllerWithIdentifier:@"LoginVC"];
        nav=[[UINavigationController alloc] initWithRootViewController:LoginVC];
    }
    else if(terms == 0){
        TermsOfServiceVC *TOSVC=[storyBoard instantiateViewControllerWithIdentifier:@"TermsOfServiceVC"];
        nav=[[UINavigationController alloc] initWithRootViewController:TOSVC];
    }
    else if(tell == 0){
        TellUSWhatYouLoveVC *tellUs=[storyBoard instantiateViewControllerWithIdentifier:@"TellUSWhatYouLoveVC"];
        nav=[[UINavigationController alloc] initWithRootViewController:tellUs];
    }
    else{
        HomeVC *homeVC=[storyBoard instantiateViewControllerWithIdentifier:@"HomeVC"];
        nav=[[UINavigationController alloc] initWithRootViewController:homeVC];
    }
    nav.navigationBar.hidden=YES;
    UIViewController *leftSideMenuViewController = [storyBoard instantiateViewControllerWithIdentifier:@"leftSideMenuViewController"];
    UIViewController *rightSideMenuViewController = [storyBoard instantiateViewControllerWithIdentifier:@"rightSideMenuViewController"];
    [container setLeftMenuViewController:leftSideMenuViewController];
    [container setRightMenuViewController:rightSideMenuViewController];
    [container setCenterViewController:nav];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
   
}
-(BOOL)application:(UIApplication *)application
openURL:(NSURL *)url
sourceApplication:(NSString *)sourceApplication
annotation:(id)annotation{
    

    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
    
}
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        isReach =TRUE;
        NSLog(@"reachable");
        
    }
    else
    {
        isReach=FALSE;
        NSLog(@"notreachable");
    }
}

@end
