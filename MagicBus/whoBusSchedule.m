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

-(id)init
{
    arrivals = [[NSMutableArray alloc] init];
    return self;
}

-(void)getLatestBusSchedule
{
     NSError* __autoreleasing* urlError = NULL;
     NSString *testXMLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://mbus.pts.umich.edu/shared/public_feed.xml"] encoding:NSASCIIStringEncoding error:urlError];
    
     NSError *parseError = nil;
     xmlDictionary = [XMLReader dictionaryForXMLString:testXMLString error:&parseError];
    [arrivals removeAllObjects];
    NSDictionary* routes = xmlDictionary[@"livefeed"][@"route"];
    for (NSDictionary *route in routes) {
        NSString *routeName = route[@"name"][@"text"];
        int stopCount = [route[@"stopcount"][@"text"] intValue];
        for(int stopNumber = 0; stopNumber < stopCount; stopNumber++)
        {
            NSDictionary* stop = route[@"stop"][stopNumber];
            if(![stop[@"toacount"][@"text"] isEqualToString:@"0"])
            {
                NSMutableDictionary* arrival = [[NSMutableDictionary alloc] init];
                [arrival setObject:routeName forKey:@"routeName"];
                [arrival setObject:stop[@"name"][@"text"] forKey:@"stopName"];
                [arrival setObject:stop[@"latitude"][@"text"] forKey:@"latitude"];
                [arrival setObject:stop[@"longitude"][@"text"] forKey:@"longitude"];
                [arrival setObject:[NSString stringWithFormat:@"%@", stop[@"toa1"][@"text"]] forKey:@"arrivalTime"];
                [arrival setObject:[whoBusSchedule prettifyTime:[arrival valueForKey:@"arrivalTime"]] forKey:@"prettyTime"];
                [arrivals addObject:arrival];
            }
        }
    }
    [arrivals sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        return [[obj1 valueForKey:@"arrivalTime"] floatValue] > [[obj2 valueForKey:@"arrivalTime"] floatValue];
    }];
}

-(void)sortArrivalsByDistance:(CLLocation *)userLocation;
{
    [arrivals sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        CLLocation *stop1Location = [[CLLocation alloc] initWithLatitude:[[obj1 valueForKey:@"latitude"] floatValue] longitude:[[obj1 valueForKey:@"longitude"] floatValue]];
        CLLocation *stop2Location = [[CLLocation alloc] initWithLatitude:[[obj2 valueForKey:@"latitude"] floatValue] longitude:[[obj2 valueForKey:@"longitude"] floatValue]];
        return [userLocation distanceFromLocation:stop1Location] > [userLocation distanceFromLocation:stop2Location];
    }];
}

-(int)getNumberOfArrivals
{
    return [[NSNumber numberWithLong:[arrivals count]] intValue];
}

-(NSDictionary *)getArrivalAtIndex:(int)index
{
    return [arrivals objectAtIndex:index];
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

+(NSString *)prettifyTime:(NSString *)seconds
{
    int iSeconds = [seconds intValue];
    return [NSString stringWithFormat:@"%d min", (iSeconds / 60)];
}


@end
