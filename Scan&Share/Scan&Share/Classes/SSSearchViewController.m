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
#import "SSHistory.h"

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
    [self.navigationController setHidesBottomBarWhenPushed:YES];
  
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
        
        NSArray *userHistory = (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
        NSMutableArray *history = [NSMutableArray array];
       
        if(userHistory)
        {
            [history addObjectsFromArray:userHistory];
           
        }   
        
        SSHistory *historyObject = [[SSHistory alloc] init];
        historyObject.content = searchTextField.text;
        historyObject.type = @"NameSearch";
        historyObject.date = [NSDate date];
        
        [self saveCustomObjectInHistory:historyObject];
        
        [self performSegueWithIdentifier:@"searchToResultPush" sender:resultList];

    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
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

- (void)saveCustomObjectInHistory:(SSHistory *)obj {
    NSArray *userHistory = (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
    NSMutableArray *history = [NSMutableArray array];
    
    if(userHistory)
    {
        [history addObjectsFromArray:userHistory];
        
    }
    
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [history addObject:myEncodedObject];
    [[NSUserDefaults standardUserDefaults] setObject:history forKey:@"history"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -
#pragma mark UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
