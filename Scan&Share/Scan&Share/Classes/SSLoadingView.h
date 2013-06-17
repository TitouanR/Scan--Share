//
//  SSLoadingView.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 17/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSLoadingView : UIView

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)start;
- (void)stop;
- (void)setUp;

@end
