//
//  stopsViewController.m
//  MagicBus
//
//  Created by Ben Perkins on 10/12/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import "stopsViewController.h"
#import "UIStopIconView.h"
#import "whoBusSchedule.h"

@interface stopsViewController ()

@end

@implementation stopsViewController
int searchBarHeight = 24;
int tabBarHeight = 50; // Todo: Get this properly

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    [self.view addSubview:[[UINavigationBar alloc] initWithFrame:statusBarFrame]];
    
    self.arrivalTable.dataSource = self;
    arrivalArray = [[NSMutableArray alloc] init];
    busSchedule = [[whoBusSchedule alloc] init];
    userLocationController = [[whoUserLocationController alloc] init];
    
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
    
    // Add "pull to refresh" to table
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_arrivalTable insertSubview:refreshControl atIndex:0];
    //[refreshControl setAutoresizingMask:(UIViewAutoresizingFlexibleTopMargin)];
    
    //[[refreshControl.subviews objectAtIndex:0] setFrame:CGRectMake(([_arrivalTable frame].size.width / 4), 0, 20, 30)];
    
    
    [_stopsScrollView setContentInset:UIEdgeInsetsMake([[UIApplication sharedApplication] statusBarFrame].size.height, 0, 0, 0)];
    [_stopsScrollView setScrollIndicatorInsets:UIEdgeInsetsMake([[UIApplication sharedApplication] statusBarFrame].size.height, 0, 0, 0)];
    [_arrivalTable setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, tabBarHeight, 0)];
    [_arrivalTable setContentInset:UIEdgeInsetsMake(0, 0, tabBarHeight, 0)];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{

    [_stopsScrollView setContentSize:CGSizeMake(320, 175)]; // These won't fire in viewDidLoad
    [_stopsScrollView setContentOffset:CGPointMake(0, searchBarHeight) animated:NO];
    [_stopsScrollView setAutoresizesSubviews:NO];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [_stopsScrollView setContentSize:CGSizeMake(320, 175)]; // These won't fire in viewDidLoad
    [_stopsScrollView setContentOffset:CGPointMake(0, searchBarHeight) animated:NO];
    
    
    CGRect frame = [_arrivalTable frame];
    frame.size.height = [UIScreen mainScreen].bounds.size.height - ([_stopsScrollView frame].size.height + [_stopsScrollView frame].origin.y); // Todo: Figure out why bottom constraint isn't working
    [_arrivalTable setFrame:frame];
    
    [self setStopsScrollViewContentHeightForRows:2];
    
    //[self performSelectorInBackground:@selector(getLatestBusSchedule) withObject:self];
    [self performSelectorInBackground:@selector(updateArrivalsTable) withObject:self];
    NSLog(@"%@", [userLocationController getMostRecentLocation]);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrivalArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ArrivalCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *arrival = [arrivalArray objectAtIndex:indexPath.row];

    [cell.textLabel setText:[arrival valueForKey:@"stopName"]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ will arrive in %@", [arrival valueForKey:@"routeName"], [arrival valueForKey:@"prettyTime"]]];
    [cell.detailTextLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [cell.detailTextLabel setNumberOfLines:2];
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

- (void)updateArrivalsTable
{
    [busSchedule getLatestBusSchedule];
    [busSchedule sortArrivalsByDistance:[userLocationController getMostRecentLocation]];
    [arrivalArray removeAllObjects];
    int arrivalCount = [busSchedule getNumberOfArrivals];
    for(int index = 0; index < arrivalCount; index++)
    {
        NSDictionary *arrival = [busSchedule getArrivalAtIndex:index];
        [arrivalArray addObject:arrival];
    }
    [_arrivalTable reloadData];
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

- (void)refresh:(id)sender
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    // Add a task to the group
    dispatch_group_async(group, queue, ^{
        [self updateArrivalsTable];
    });
    
    // Add another task to the group
    dispatch_group_notify(group, queue, ^{
        [refreshControl endRefreshing];
    });

}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
