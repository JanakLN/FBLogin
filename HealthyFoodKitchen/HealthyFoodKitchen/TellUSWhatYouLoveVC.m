//
//  TellUSWhatYouLoveVC.m
//  HealthyFoodKitchen
//
//  Created by macmini5 on 27/08/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "TellUSWhatYouLoveVC.h"

@implementation TellUSWhatYouLoveVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initLocationManager];
}

-(void)initLocationManager{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }else{
        NSLog(@"Already Authorised");
    }
}
- (IBAction)btnFindYourFoodClicked:(id)sender {
    
    [Helper setNsuserValue:KTellUs value:@"1"];
    
    HomeVC *homeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:homeVC animated:YES];
}

@end
