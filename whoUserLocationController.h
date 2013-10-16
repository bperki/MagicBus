//
//  whoUserLocationController.h
//  MagicBus
//
//  Created by Ben Perkins on 10/16/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface whoUserLocationController : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

- (CLLocation*) getMostRecentLocation;

@end
