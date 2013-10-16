//
//  whoUserLocationController.m
//  MagicBus
//
//  Created by Ben Perkins on 10/16/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import "whoUserLocationController.h"

@implementation whoUserLocationController
{
    
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [locationManager startUpdatingLocation];
        [locationManager performSelector:@selector(stopUpdatingLocation) withObject:nil afterDelay:5];
    }
    return self;
}

- (CLLocation*) getMostRecentLocation
{
    return [locationManager location];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    currentLocation = newLocation;
    NSLog(@"%@", currentLocation);
}

@end
