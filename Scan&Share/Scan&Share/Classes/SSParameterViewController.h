//
//  SSParameterViewController.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 08/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSLoginView.h"

@interface SSParameterViewController : UIViewController

@property (nonatomic, strong) IBOutlet SSLoginView *loginView;

- (IBAction)showLoginView:(id)sender;


@end
