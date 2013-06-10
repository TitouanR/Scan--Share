//
//  SSParameterViewController.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 08/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSParameterViewController.h"
#import "ASDepthModalViewController.h"
#import "SSPrice.h"
#import  <QuartzCore/QuartzCore.h>

@interface SSParameterViewController ()

@end

@implementation SSParameterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}



- (IBAction)clearHistory:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"history"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)test:(id)sender {
    
    SSPrice *price = [[SSPrice alloc] init];
    price.value = [NSNumber numberWithFloat:0.64];
    price.location = @"35.2:16.3";
    
    [[SSApi sharedApi] modifyProduct:@"3068320052007" withPrice:price withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}
@end
