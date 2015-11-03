//
//  HomeVC.h
//  HealthyFoodKitchen
//
//  Created by macmini5 on 28/08/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Helper.h"
#import "MFSideMenu.h"
#import "Manager.h"
@interface HomeVC : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
    NSString *_address;
    
    Manager *Man;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    IBOutlet UILabel *lblCityName;
    IBOutlet MKMapView *mapView;
}
- (IBAction)btnSideMenuClicked:(id)sender;
- (IBAction)btnFilterClicked:(id)sender;
- (IBAction)btnSearchClicked:(id)sender;

@end
