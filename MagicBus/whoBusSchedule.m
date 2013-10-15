//
//  whoBusSchedule.m
//  MagicBus
//
//  Created by Ben Perkins on 10/14/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import "whoBusSchedule.h"
#import "XMLReader.h"

@implementation whoBusSchedule

-(void)getLatestBusSchedule
{
     NSError* __autoreleasing* urlError = NULL;
     NSString *testXMLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://mbus.pts.umich.edu/shared/public_feed.xml"] encoding:NSASCIIStringEncoding error:urlError];
    
     NSError *parseError = nil;
     xmlDictionary = [XMLReader dictionaryForXMLString:testXMLString error:&parseError];
    
}

-(void)printBusSchedule
{
    if(xmlDictionary == NULL)
    {
        [NSException raise:@"Null bus schedule" format:@"Bus schedule has not been retrieved"];
    }
    else
    {
        NSLog(@"%@", xmlDictionary);
    }
}

@end
