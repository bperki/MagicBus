//
//  whoBusSchedule.h
//  MagicBus
//
//  Created by Ben Perkins on 10/14/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface whoBusSchedule : NSObject
{
    NSDictionary *xmlDictionary;
}

-(void)getLatestBusSchedule;
-(void)printBusSchedule;

@end
