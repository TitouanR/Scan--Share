//
//  SSProfileViewController.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 05/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSProfileViewController.h"
#import "SSApi.h"
#import "SSComment.h"
#import "SSPrice.h"

@interface SSProfileViewController ()

@end

@implementation SSProfileViewController

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
- (IBAction)testLogin:(id)sender {
    [[SSApi sharedApi] getLoggedInWithUsername:@"username" andPassword:@"password" withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
    
}
- (IBAction)testComments:(id)sender {
//    [[SSApi sharedApi] getCommentsFromProduct:@"20080563" fromStartIndex:0 withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        
//    }];
    SSComment *comment = [[SSComment alloc] init];
    comment.content = @"Toto test un commentaire";
    comment.date = @"05/06/2013";
    comment.author = @"toto";
    
    SSPrice *price = [[SSPrice alloc] init];
    price.value = [NSNumber numberWithDouble:2.34];
    price.location = @"49.41568:2.81774";
    
    [[SSApi sharedApi] modifyProduct:@"20080563" withPrice:price withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}
- (IBAction)testRegister:(id)sender {
    [[SSApi sharedApi] registerWithUsername:@"karim" password:@"karim" mail:@"karim271290@yopmail.com" age:22 andJob:@"student" withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}

@end
