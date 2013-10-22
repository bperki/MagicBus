//
//  tabViewController.m
//  MagicBus
//
//  Created by Benjamin Perkins on 10/22/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import "tabViewController.h"

@interface tabViewController ()

@end

@implementation tabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        arrivalArray = [[NSMutableArray alloc] init];
        busSchedule = [[whoBusSchedule alloc] init];
        userLocationController = [[whoUserLocationController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
