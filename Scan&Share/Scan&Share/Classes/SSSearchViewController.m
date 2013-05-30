//
//  SSSearchViewController.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 11/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSSearchViewController.h"
#import "SSApi.h"

@interface SSSearchViewController ()

@end

@implementation SSSearchViewController

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
    [[SSApi sharedApi] getProductWithEAN:@"3068320052007"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSearchTextField:nil];
    [self setSearchButton:nil];
    [self setAroundMeButton:nil];
    [super viewDidUnload];
}

- (IBAction)search:(id)sender {
}

- (IBAction)aroundMe:(id)sender {
}

@end
