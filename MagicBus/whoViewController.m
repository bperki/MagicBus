//
//  whoViewController.m
//  MagicBus
//
//  Created by Ben Perkins on 10/12/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import "whoViewController.h"
#import "UIStopIconView.h"
#import "whoBusSchedule.h"

@interface whoViewController ()

@end

@implementation whoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrivalTable.dataSource = self;
    self.arrivalArray = [[NSMutableArray alloc] initWithObjects:
                        @"Bursley Baits",
                        @"Northwood Express",
                        @"Commuter Southbound",
                        @"Diag to Diag Express",
                        @"Commuter Northboard",
                        nil];
    
    [self setBackgroundImageForStopsScrollView:@"NorthCampus_Afternoon_Blur.jpg"];
    
    UIStopIconView* stopIcon1 = [[UIStopIconView alloc] UIStopIconViewWithImage:@"CCTC.jpg" andStopName:@"Central Campus Transit" andRadius:67 atIndex:0 inContainerOfSize: _stopsScrollView.frame.size parentView:(_stopsScrollView)];
    [stopIcon1 nextBusIs:@"Bursley Baits" arrivingIn:2];
    [_stopsScrollView addSubview:stopIcon1];
    
    UIStopIconView* stopIcon2 = [[UIStopIconView alloc] UIStopIconViewWithImage:@"BB_E.jpg" andStopName:@"Bursley Baits (East)" andRadius:67 atIndex:1 inContainerOfSize: _stopsScrollView.frame.size parentView:(_stopsScrollView)];
    [stopIcon2 nextBusIs:@"Commuter South" arrivingIn:4];
    [_stopsScrollView addSubview:stopIcon2];
    
    UIStopIconView* stopIcon3 = [[UIStopIconView alloc] UIStopIconViewWithImage:@"PP_S.jpg" andStopName:@"Pierpoint Commons (South)" andRadius:67 atIndex:2 inContainerOfSize: _stopsScrollView.frame.size parentView:(_stopsScrollView)];
    [stopIcon3 nextBusIs:@"Northwood" arrivingIn:5];
    [_stopsScrollView addSubview:stopIcon3];
    
    UIStopIconView* stopIcon4 = [[UIStopIconView alloc] UIStopIconViewWithImage:@"PP_N.jpg" andStopName:@"Pierpont Commons (North)" andRadius:67 atIndex:3 inContainerOfSize: _stopsScrollView.frame.size parentView:(_stopsScrollView)];
    [stopIcon4 nextBusIs:@"Bursley Baits" arrivingIn:10];
    [_stopsScrollView addSubview:stopIcon4];
}

- (void)viewDidAppear:(BOOL)animated
{
    [_stopsScrollView setContentSize:CGSizeMake(320, 175)];
    [_stopsScrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_stopsScrollView setContentOffset:CGPointMake(0, 44)];
    [self setStopsScrollViewContentHeightForRows:2];
    
    //whoBusSchedule *busSchedule = [[whoBusSchedule alloc] init];
    //[busSchedule getLatestBusSchedule];
    //[busSchedule printBusSchedule];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrivalArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ArrivalCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *arrival = [self.arrivalArray objectAtIndex:indexPath.row];

    [cell.textLabel setText:arrival];
    [cell.detailTextLabel setText:@"Some bus in some minutes"];
    return cell;
}

- (void)setStopsScrollViewContentHeightForRows:(int) rows
{
    [_stopsScrollView setContentSize:CGSizeMake(320, (rows*175)+44)];
    
    [_stopsScrollViewBackgroundImage setTranslatesAutoresizingMaskIntoConstraints:YES];
    [_stopsScrollViewBackgroundImage setFrame:CGRectMake(0, -75, 320, 350)];
}

-(void)setBackgroundImageForStopsScrollView:(NSString *)imageName
{
    [_stopsScrollViewBackgroundImage setImage:[UIImage imageNamed:imageName]];
}

- (void)addRowToArrivalTable
{
    //UITableViewCell *label = [[UITableViewCell alloc] init];
    //[_arrivalTable addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == _stopsScrollView)
    {
        CGPoint offset = [_stopsScrollView contentOffset];
        CGSize frame = [_stopsScrollView contentSize];
        CGRect backgroundImageFrame = [_stopsScrollViewBackgroundImage frame];
        //backgroundImageFrame.origin.y = ((offset.y - 44) / 5) - 50;
        backgroundImageFrame.origin.y = offset.y - (44 + 75) - (((offset.y - 44) / frame.height) * 50);
        //NSLog(@"%f of %f", offset.y, frame.height);
        [_stopsScrollViewBackgroundImage setFrame:backgroundImageFrame];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint) velocity targetContentOffset:(inout CGPoint*) targetContentOffset
{
    if(targetContentOffset->y >= 44 - 40 && targetContentOffset->y <= 44 + 20){
        targetContentOffset->y = 44;
        [_stopsScrollView setContentOffset:(*targetContentOffset) animated:YES];
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    return;
    if(scrollView == _stopsScrollView)
    {
        if(!decelerate){
            CGPoint offset = [_stopsScrollView contentOffset];
            if(offset.y >= 44 - 40 && offset.y <= 44 + 20){
                offset.y = 44;
                [_stopsScrollView setContentOffset:offset animated:YES];
            }
            NSLog(@"Scroll to: %d", [[NSNumber numberWithFloat:offset.y] intValue]);
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    return;
    if(scrollView == _stopsScrollView)
    {
        CGPoint offset = [_stopsScrollView contentOffset];
        if(offset.y >= 44 - 40 && offset.y <= 44 + 20){
            offset.y = 44;
            [_stopsScrollView setContentOffset:offset animated:YES];
        }
        NSLog(@"Scroll to: %d", [[NSNumber numberWithFloat:offset.y] intValue]);
    }
}


@end
