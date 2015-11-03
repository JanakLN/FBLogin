//
//  HomeVC.m
//  HealthyFoodKitchen
//
//  Created by macmini5 on 28/08/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "HomeVC.h"

@implementation HomeVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    Man = [Manager sharedInstance];
    /*===START UPDATING LOCATION===*/
    mapView.delegate=self;
    locationManager = [CLLocationManager new];
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }else{
        NSLog(@"Already Authorised");
    }
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
}
-(void)viewDidLayoutSubviews{
}
- (IBAction)btnSideMenuClicked:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)btnFilterClicked:(id)sender {
}

- (IBAction)btnSearchClicked:(id)sender {
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    [self getAddressFromLatLon:location.coordinate.latitude withLongitude:location.coordinate.longitude];
//    [Helper getAddressFromLocation:location complationBlock:^(NSString * address) {
//        if(address) {
//            _address = address;
//        }
//        else{
//            NSLog(@"Retriving Again");
//        }
//    }];
}

-(void)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude{
    /*==SILENTLY GETTING LOCATION===*/
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f",pdblLatitude, pdblLongitude];
    
    [Man getLocattion:nil url:urlString completionBlock:^(BOOL success) {
        if(success){
            lblCityName.adjustsFontSizeToFitWidth=YES;
            lblCityName.text= [[Man.address componentsSeparatedByString:@","] objectAtIndex:0];
        }
        else{
            
        }
    }];
}

@end
