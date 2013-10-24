//
//  mapViewController.h
//  MagicBus
//
//  Created by Benjamin Perkins on 10/22/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "whoUserLocationController.h"

@interface mapViewController : UIViewController 
{
    CLLocation *location;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (void) userLocationChanged:(NSNotification *)notification;

@end
