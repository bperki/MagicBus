//
//  whoBusSchedule.h
//  MagicBus
//
//  Created by Ben Perkins on 10/14/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface whoBusSchedule : NSObject
{
    NSDictionary *xmlDictionary;
    NSMutableArray *arrivals;
}

-(void)getLatestBusSchedule;
-(void)sortArrivalsByDistance:(CLLocation *)userLocation;
-(void)printBusSchedule;
-(int)getNumberOfArrivals;
-(NSDictionary *)getArrivalAtIndex:(int)index;
+(NSString *)prettifyTime:(NSString *)seconds;

@end
