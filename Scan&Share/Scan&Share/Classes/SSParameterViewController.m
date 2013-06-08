//
//  SSParameterViewController.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 08/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSParameterViewController.h"
#import "ASDepthModalViewController.h"
#import  <QuartzCore/QuartzCore.h>

@interface SSParameterViewController ()

@end

@implementation SSParameterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.loginView = [[SSLoginView alloc] init];
        
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.loginView.layer.cornerRadius = 12;
    self.loginView.layer.shadowOpacity = 0.7;
    self.loginView.layer.shadowOffset = CGSizeMake(6, 6);
    self.loginView.layer.shouldRasterize = YES;
    self.loginView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (IBAction)showLoginView:(id)sender {
    
    UIColor *color = nil;
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    ASDepthModalOptions options = style | ASDepthModalOptionBlurNone;

    [ASDepthModalViewController presentView:self.loginView backgroundColor:color options:options completionHandler:^{
        
    }];
  
}
@end
