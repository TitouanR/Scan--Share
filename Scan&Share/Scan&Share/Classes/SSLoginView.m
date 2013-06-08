//
//  SSLoginView.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 08/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SSLoginView.h"

@implementation SSLoginView

@synthesize loginTextField, passwordTextField;

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

- (IBAction)login:(id)sender
{
    if(!([loginTextField.text isEqualToString:@""] && [passwordTextField.text isEqualToString:@""]))
    {
        [[SSApi sharedApi] getLoggedInWithUsername:loginTextField.text andPassword:passwordTextField.text withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            
        }];
    }
    else {
        
    }
}

@end
