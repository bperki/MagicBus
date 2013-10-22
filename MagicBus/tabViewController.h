//
//  tabViewController.h
//  MagicBus
//
//  Created by Benjamin Perkins on 10/22/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "whoBusSchedule.h"
#import "whoUserLocationController.h"

@interface tabViewController : UIViewController
{
    NSMutableArray *arrivalArray;
    whoBusSchedule *busSchedule;
    whoUserLocationController *userLocationController;
}

@end
