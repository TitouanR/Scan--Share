//
//  SSAppDelegate.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 01/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSAccount.h"

@interface SSAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SSAccount *currentLoggedAccount;

@end
