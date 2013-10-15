//
//  UIStopIconView.m
//  MagicBus
//
//  Created by Ben Perkins on 10/13/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import "UIStopIconView.h"

@implementation UIStopIconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    int radius = frame.size.width / 2;
    
    if (self) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                       byRoundingCorners:UIRectCornerAllCorners
                                                             cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }   
    
    // Create UIImageView
    backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, radius * 2, radius * 2)];
    [self addSubview:backgroundImageView];
    
    // Create label background
    
    backgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, radius * (4. / 3.), radius * 2, radius)];
        [backgroundLabel setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.67]];
    [self addSubview:backgroundLabel];
    
    // Create labels
    
    nextBusTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, radius * (4. / 3.) + 2, radius * 2, 15)];
    [nextBusTitleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [nextBusTitleLabel setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    [nextBusTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [nextBusTitleLabel setText:nextBusTitle];
    
    nextBusEtaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, radius * (4. / 3.) + 18, radius * 2, 15)];
    [nextBusEtaLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [nextBusEtaLabel setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75]];;
    [nextBusEtaLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self addSubview:nextBusTitleLabel];
    [self addSubview:nextBusEtaLabel];
    
    return self;
}

-(id)UIStopIconViewWithImage:(NSString*) imageName andStopName:(NSString *)name andRadius:(float) radius atIndex:(int) index inContainerOfSize:(CGSize) containerSize parentView:(UIView *)parent
{
    int searchBarHeight = 24;
    nextBusTitle = @"Loading...";
    stopName = name;
    iconsPerRow = 2;

    int eachWidth = (containerSize.width / iconsPerRow);
    int widthInset = (eachWidth - (2 * radius)) / 2;
    int heightInset = (containerSize.height - (2 * radius)) / 2;
    int x = eachWidth * (index % iconsPerRow) + widthInset;
    int y = searchBarHeight + containerSize.height * (index / iconsPerRow) + heightInset + 25; // + 25 is for stop title
    id this = [self initWithFrame:CGRectMake(x, y, radius * 2, radius * 2)];
    [self setBackgroundImage:imageName];
    
    // Create title label and add to parent view
        // This must go in the parent view or else it will get clipped off by the mask
    int stopNameX = eachWidth * (index % iconsPerRow) + 10;
    int stopNameY = y - 35;
    int stopNameWidth = eachWidth - 15;
    int stopNameHeight = 35;
    
    stopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(stopNameX, stopNameY, stopNameWidth, stopNameHeight)];
    [stopNameLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [stopNameLabel setTextAlignment:NSTextAlignmentCenter];
    [stopNameLabel setShadowColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.33]];
    [stopNameLabel setShadowOffset:CGSizeMake(1, 1)];
    [stopNameLabel setAdjustsFontSizeToFitWidth:NO];
    [stopNameLabel setNumberOfLines:0];
    [stopNameLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
    [stopNameLabel setText:stopName];
    [parent addSubview:stopNameLabel];
    return this;
}

-(void)setBackgroundImage:(NSString *)imageName
{
    backgroundImage = imageName;
    [backgroundImageView setImage:[UIImage imageNamed:imageName]];
}

-(NSString *)backgroundImage
{
    return backgroundImage;
}

- (void)nextBusIs:(NSString *)title arrivingIn:(int)minutes
{
    nextBusTitle = title;
    [nextBusTitleLabel setText:nextBusTitle];
    [nextBusEtaLabel setText:[NSString stringWithFormat:@"%d min", minutes]];
}

- (void)viewDidLoad
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
