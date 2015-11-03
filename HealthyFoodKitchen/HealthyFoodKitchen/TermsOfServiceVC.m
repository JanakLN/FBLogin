//
//  TermsOfServiceVC.m
//  HealthyFoodKitchen
//
//  Created by macmini5 on 27/08/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "TermsOfServiceVC.h"
#import "AppDelegate.h"
#import "TellUSWhatYouLoveVC.h"
#import "Common.h"
@implementation TermsOfServiceVC
-(void)viewDidLoad{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
- (void)viewDidLayoutSubviews {
    [scroll setContentSize:CGSizeMake(screenWidth, 500)];
}
- (IBAction)btnAcceptClicked:(id)sender {
    [Helper setNsuserValue:KTOSAccepted value:@"1"];
    TellUSWhatYouLoveVC *tellVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TellUSWhatYouLoveVC"];
    [self.navigationController pushViewController:tellVC animated:YES];
}
@end
