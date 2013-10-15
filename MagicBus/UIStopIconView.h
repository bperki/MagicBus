//
//  UIStopIconView.h
//  MagicBus
//
//  Created by Ben Perkins on 10/13/13.
//  Copyright (c) 2013 perkinsb1024. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStopIconView : UIView
{
    NSString *backgroundImage;
    NSString *nextBusTitle;
    NSString *stopName;
    int nextBusEta;
    
    UIImageView *backgroundImageView;
    UILabel *backgroundLabel;
    UILabel *nextBusTitleLabel;
    UILabel *nextBusEtaLabel;
    UILabel *stopNameLabel;
    
    int iconsPerRow;
}

- (id)UIStopIconViewWithImage:(NSString*) imageName andStopName:(NSString *)name andRadius:(float) radius atIndex:(int) index inContainerOfSize:(CGSize) containerWidth parentView:(UIView *)parent;
- (void)setBackgroundImage:(NSString *)imageName;
- (NSString *)backgroundImage;
- (void)nextBusIs:(NSString *)title arrivingIn:(int)minutes;

@end
