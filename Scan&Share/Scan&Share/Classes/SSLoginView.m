//
//  SSLoginView.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 08/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SSLoginView.h"
#import "SSAccount.h"
#import "SSAppDelegate.h"
#import "ASDepthModalViewController.h"

@implementation SSLoginView

@synthesize loginTextField, passwordTextField, isLoggedIn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

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
    self.layer.cornerRadius = 12;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowOffset = CGSizeMake(6, 6);
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    loginTextField.delegate = self;
    passwordTextField.delegate = self;
    passwordTextField.secureTextEntry = YES;
    isLoggedIn = false;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:@"loginSuccessNotification" object:nil];
}

- (IBAction)login:(id)sender
{
    if(!([loginTextField.text isEqualToString:@""] && [passwordTextField.text isEqualToString:@""]))
    {
        [[SSApi sharedApi] getLoggedInWithUsername:loginTextField.text andPassword:passwordTextField.text withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            SSAccount *account = (SSAccount *)[mappingResult.array objectAtIndex:0];
            SSAppDelegate *appDelegate = (SSAppDelegate *)[UIApplication sharedApplication].delegate;
            appDelegate.currentLoggedAccount = account;
            
            isLoggedIn = true;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connexion réussie !" message:@"La connexion a été établie avec succès." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
          //  [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccessNotification" object:nil];
            
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            [[SSApi sharedApi] errorHTTPHandler:error];
        }];
    }
    else {
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField isEqual:passwordTextField]){
       [UIView animateWithDuration:0.2 animations:^{
           CGRect frame = self.frame;
           frame.origin.y -= 50;
           [self setFrame:frame];}];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField isEqual:passwordTextField]){
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.frame;
            frame.origin.y += 50;
            [self setFrame:frame];}];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [ASDepthModalViewController dismiss];
}
@end
