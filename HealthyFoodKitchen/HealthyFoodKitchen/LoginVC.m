//
//  LoginVC.m
//  HealthyFoodKitchen
//
//  Created by macmini5 on 24/08/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "LoginVC.h"
#import "MFSideMenu.h"
#import "Common.h"
#import "TermsOfServiceVC.h"
#import "SideMenuViewController.h"
@implementation LoginVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self boxEffect:view];
    [GIDSignIn sharedInstance].uiDelegate = self;
    Man =[Manager sharedInstance];
    [GIDSignIn sharedInstance].delegate = self;
    NSLog(@"%@",[Helper getNsuserValue:KLoggedIN]);
}

- (IBAction)btnLoginFBClicked:(id)sender {
    NSLog(@"btnLoginFBClicked");
    [self logIn];
}

- (IBAction)btnLoginGoogleClicked:(id)sender {
     NSLog(@"btnLoginGoogleClicked");
    [[GIDSignIn sharedInstance]signIn];
}
- (IBAction)showLeftMenuPressed:(id)sender{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}
- (IBAction)btnBecomSeller:(id)sender {
    [Helper openUrlInSafari:@"http://iossolution.16mb.com"];
}
-(void)logIn
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    //        [Helper showGlobalProgressHUDWithTitle:@"Loading"];
    [login logInWithReadPermissions:@[@"email",@"public_profile",@"email"]
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error)
         {
             NSLog(@"%@",error.localizedDescription);
             UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Sorry.Failed to Login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alert show];
             
             return;
         }
         else
         {
             if ([result.grantedPermissions containsObject:@"email"])
             {
                 NSLog(@"result is:%@",result);
                 NSLog(@"resultis:%@",result);
                 [Helper showGlobalProgressHUDWithTitle:@"Loading"];
                 [self fetchUserInfo];
                 [Helper dismissGlobalHUD];
             }
         }
     }];
}
-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture, email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
         {
             if (!error)
             {
                 NSLog(@"resultis:%@",result);
                 NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", [result objectForKey:@"id"]]];
                 NSLog(@"pic url:%@",pictureURL);
                 
                 NSString *fname=[result objectForKey:@"first_name"];
                 NSString *lname=[result objectForKey:@"last_name"];
                 NSString *fb_id=[result objectForKey:@"id"];
                 NSString *email=[result objectForKey:@"email"];
                 
                 NSString *name=[NSString stringWithFormat:@"%@ %@",fname,lname];
                 
                 dictUserDetails=[[NSMutableDictionary alloc] init];
                 [dictUserDetails setValue:fb_id forKey:@"userID"];
                 [dictUserDetails setValue:name forKey:@"userName"];
                 [dictUserDetails setValue:email forKey:@"email"];
                 [dictUserDetails setValue:pictureURL forKey:@"url"];
                 
                 NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictUserDetails];
                 [[NSUserDefaults standardUserDefaults] setObject:data forKey:KUserDetails];
                 [[NSUserDefaults standardUserDefaults] synchronize];

                 
                 NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:fname,@"user_name",lname,@"last_name",fb_id,@"facebook_id",pictureURL,@"profile_picture", nil];
                 NSLog(@"dict fblogin:%@",dict);
                 
                 [Helper setNsuserValue:KLoggedIN value:@"1"];
                 
                 TermsOfServiceVC *TOSVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TermsOfServiceVC"];
                 [self.navigationController pushViewController:TOSVC animated:YES];
                 
//                 if (isReach)
//                 {
//                     [Man Facebook_login:dict completionBlock:^(BOOL success)
//                      {
//                          if (success == 1)
//                          {
//                              isFBlogin = YES;
//                              [Helper dismissGlobalHUD];
//                              TermsOfServiceVC *TOSVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TermsOfServiceVC"];
//                              [self.navigationController pushViewController:TOSVC animated:YES];
//                          }
//                          
//                          else
//                          {
//                              [Helper dismissGlobalHUD];
//                              UIAlertView *alert = [[ UIAlertView alloc]initWithTitle:@"" message:@"Invalid Email or Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                              [alert show];
//                              NSLog(@"Login unsucces");
//                          }
//                      }];
//                     
//                     
//                 }
//                 else
//                 {
//                     UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"No internet connection.Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                     [alert show];
//                 }
//                 
//                 
             }
             else
             {
                 UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Sorry.Failed to Login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
                 NSLog(@"Error %@",error);
             }
         }];
        
    }
    
}

/*===LOGIN WITH GOOGLE+ DELEGATE===*/
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    if(error == nil){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"Yes" forKey:@"LoggedIn"];
        NSString *imageURL;
        if ([GIDSignIn sharedInstance].currentUser.profile.hasImage)
        {
            CGSize thumbSize = CGSizeMake(screenWidth,screenHeight);
            NSUInteger dimension = round(thumbSize.width * [[UIScreen mainScreen] scale]);
            imageURL = [NSString stringWithFormat:@"%@",[user.profile imageURLWithDimension:dimension]];
        }
        dictUserDetails=[[NSMutableDictionary alloc] init];
        [dictUserDetails setValue:user.userID forKey:@"userID"];
        [dictUserDetails setValue:user.profile.name forKey:@"userName"];
        [dictUserDetails setValue:user.profile.email forKey:@"email"];
        [dictUserDetails setValue:imageURL forKey:@"url"];
    
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictUserDetails];
         [[NSUserDefaults standardUserDefaults] setObject:data forKey:KUserDetails];
        [[NSUserDefaults standardUserDefaults] synchronize];
                
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:KUserDetails]);
        
        SideMenuViewController *sideVC=[[SideMenuViewController alloc] init];
        [sideVC setAvatarURL:imageURL];
        [Helper setNsuserValue:KLoggedIN value:@"1"];
        
        TermsOfServiceVC *TOSVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TermsOfServiceVC"];
        [self.navigationController pushViewController:TOSVC animated:YES];
    }
    else{
        [Helper globalAlert:@"Something went wrong."];
    }
}
- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}

//- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
//    [myActivityIndicator stopAnimating];
//}
//
//// Present a view that prompts the user to sign in with Google
//- (void)signIn:(GIDSignIn *)signIn
//presentViewController:(UIViewController *)viewController {
//    [self presentViewController:viewController animated:YES completion:nil];
//}
//
//// Dismiss the "Sign in with Google" view
//- (void)signIn:(GIDSignIn *)signIn
//dismissViewController:(UIViewController *)viewController {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
-(void)boxEffect:(UIView*)view1{
    
    view1.backgroundColor = [UIColor whiteColor];
    CALayer *ScrlViewLayer = [view1 layer];
    [ScrlViewLayer setMasksToBounds:NO ];
    [ScrlViewLayer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [ScrlViewLayer setShadowOpacity:1.0 ];
    [ScrlViewLayer setShadowRadius:6.0 ];
    [ScrlViewLayer setShadowOffset:CGSizeMake( 0 , 0 )];
    [ScrlViewLayer setShouldRasterize:YES];
    [ScrlViewLayer setCornerRadius:5.0];
    [ScrlViewLayer setBorderColor:[UIColor lightGrayColor].CGColor];
    [ScrlViewLayer setBorderWidth:1.0];
    [ScrlViewLayer setShadowPath:[UIBezierPath bezierPathWithRect:view1.bounds].CGPath];
}
@end
