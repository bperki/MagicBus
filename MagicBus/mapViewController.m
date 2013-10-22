//
//  mapViewController.m
//  MagicBus
//
//  Created by Benjamin Perkins on 10/22/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import "mapViewController.h"

@interface mapViewController ()

@end

@implementation mapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userLocationChanged:)
                                             name:@"locationChanged"
                                             object:nil];
	// Do any additional setup after loading the view.
}

- (void) userLocationChanged:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    location = [info valueForKey:@"location"];
    [_mapView setRegion:MKCoordinateRegionMake([location coordinate], MKCoordinateSpanMake(1.0f, 1.0f)) animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
