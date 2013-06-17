//
//  SSLoadingView.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 17/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSLoadingView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SSLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.activityIndicator = [[UIActivityIndicatorView alloc] init];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setUp
{
    [self setFrame:CGRectMake(0, 0, 100, 100)];
    [self setBackgroundColor:[UIColor blackColor]];
    [self setAlpha:0.8];
    [self addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    self.layer.cornerRadius = 12;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowOffset = CGSizeMake(6, 6);
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

- (void)start
{
    [self.activityIndicator startAnimating];
}

- (void)stop
{
    [self.activityIndicator stopAnimating];
}

@end
