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
int searchBarHeight = 24;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    [self.view addSubview:[[UINavigationBar alloc] initWithFrame:statusBarFrame]];
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
    
    [_stopsScrollView setContentSize:CGSizeMake(320, 175)]; // I don't think these actually apply until viewDidAppear
    [_stopsScrollView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    [_stopsScrollView setContentOffset:CGPointMake(0, searchBarHeight)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [_stopsScrollView setContentSize:CGSizeMake(320, 175)];
    [_stopsScrollView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    [_stopsScrollView setContentOffset:CGPointMake(0, searchBarHeight)];
    [self setStopsScrollViewContentHeightForRows:2];
    
    //whoBusSchedule *busSchedule = [[whoBusSchedule alloc] init];
    //[busSchedule getLatestBusSchedule];
    //[busSchedule printBusSchedule];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrivalArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ArrivalCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *arrival = [self.arrivalArray objectAtIndex:indexPath.row];

    [cell.textLabel setText:arrival];
    [cell.detailTextLabel setText:@"Some bus in some minutes"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == _arrivalTable)
    {
        if (section == 0)
        {
            return @"Arriving Soon Near You";
        }
    }
    return @"";
}

- (void)setStopsScrollViewContentHeightForRows:(int)rows
{
    CGRect frame = [_stopsScrollView frame];
    [_stopsScrollView setContentSize:CGSizeMake(frame.size.width, (rows*frame.size.height)+searchBarHeight)];
    
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
        //backgroundImageFrame.origin.y = ((offset.y - searchBarHeight) / 5) - 50;
        backgroundImageFrame.origin.y = offset.y - (searchBarHeight + 75) - (((offset.y - searchBarHeight) / frame.height) * 50);
        //NSLog(@"%f of %f", offset.y, frame.height);
        [_stopsScrollViewBackgroundImage setFrame:backgroundImageFrame];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint) velocity targetContentOffset:(inout CGPoint*) targetContentOffset
{
    if(targetContentOffset->y >= searchBarHeight - 40 && targetContentOffset->y <= searchBarHeight + 20){
        targetContentOffset->y = searchBarHeight;
        [_stopsScrollView setContentOffset:(*targetContentOffset) animated:YES];
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    return;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    return;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
