//
//  TellUSWhatYouLoveVC.h
//  HealthyFoodKitchen
//
//  Created by macmini5 on 27/08/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Common.h"
#import "Helper.h"
#import "HomeVC.h"
@interface TellUSWhatYouLoveVC : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager * locationManager;
}
@end
