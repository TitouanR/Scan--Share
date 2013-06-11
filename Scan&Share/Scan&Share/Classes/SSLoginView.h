//
//  SSLoginView.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 08/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSLoginView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *loginTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, assign) BOOL isLoggedIn;

- (IBAction)login:(id)sender;

@end
