//
//  whoViewController.h
//  MagicBus
//
//  Created by Ben Perkins on 10/12/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "whoBusSchedule.h"
#import "whoUserLocationController.h"

@interface whoViewController : UIViewController <UITableViewDataSource>
{
    NSMutableArray *arrivalArray;
    whoBusSchedule *busSchedule;
    whoUserLocationController *userLocationController;
}
@property (weak, nonatomic) IBOutlet UIScrollView *stopsScrollView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *stopsScrollViewBackgroundImage;
@property (weak, nonatomic) IBOutlet UITableView *arrivalTable;
@property (weak, nonatomic) IBOutlet UITableViewCell *arrivalCell;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

- (void)setBackgroundImageForStopsScrollView:(NSString *)imageName;
- (void)updateArrivalsTable;


@end
