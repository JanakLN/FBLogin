//
//  LoginVC.h
//  HealthyFoodKitchen
//
//  Created by macmini5 on 24/08/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Helper.h"
#import "Manager.h"
#import "TermsOfServiceVC.h"
#import <Google/SignIn.h>

@interface LoginVC : UIViewController<GIDSignInUIDelegate,GIDSignInDelegate>
{
    Manager *Man;
    UIActivityIndicatorView *myActivityIndicator;
    NSMutableDictionary *dictUserDetails;
    IBOutlet UIView *view;
}

@property (strong, nonatomic) IBOutlet GIDSignInButton *signInButton;
- (IBAction)btnLoginFBClicked:(id)sender;

- (IBAction)btnLoginGoogleClicked:(id)sender;
@end
