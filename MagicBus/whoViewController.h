//
//  whoViewController.h
//  MagicBus
//
//  Created by Ben Perkins on 10/12/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface whoViewController : UIViewController <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *stopsScrollView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *stopsScrollViewBackgroundImage;
@property (weak, nonatomic) IBOutlet UITableView *arrivalTable;
@property (weak, nonatomic) IBOutlet UITableViewCell *arrivalCell;

@property (strong, nonatomic) NSMutableArray *arrivalArray;

- (void)setBackgroundImageForStopsScrollView:(NSString *)imageName;
- (void)addRowToArrivalTable;


@end
