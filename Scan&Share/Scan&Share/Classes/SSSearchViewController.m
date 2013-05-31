//
//  SSSearchViewController.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 11/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSSearchViewController.h"
#import "SSApi.h"
#import "SSResultList.h"
#import "SSSearchResultViewController.h"

@interface SSSearchViewController ()

@end

@implementation SSSearchViewController

@synthesize searchTextField;

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
    
    searchTextField.delegate = self;
  
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
    [[SSApi sharedApi] searchProductWithName:searchTextField.text withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        SSResultList *resultList = (SSResultList *)[mappingResult.array objectAtIndex:0];
        RKLogInfo(@"Load collection of Products: %@", resultList);
        
        [self performSegueWithIdentifier:@"searchToResultPush" sender:resultList];

    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}

- (IBAction)aroundMe:(id)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ([[segue identifier] isEqualToString:@"searchToResultPush"]) {
        
        // Get the destination view controller
        SSSearchResultViewController *resultViewController = [segue destinationViewController];
        
        // Get the product to send from (id)sender
        SSResultList *resultList =(SSResultList*)sender;
        
        // Set the product object in the destination VC
        resultViewController.resultList = resultList;
    }
    
}

#pragma mark -
#pragma mark UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
