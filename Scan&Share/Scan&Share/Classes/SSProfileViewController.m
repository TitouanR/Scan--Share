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
#import "SSProfileViewCell.h"
#import "SSHistory.h"

@interface SSProfileViewController ()

@end

@implementation SSProfileViewController

@synthesize history;

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

- (void)viewWillAppear:(BOOL)animated
{
    history = [self loadCustomObjectWithKey:@"history"];

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)testLogin:(id)sender {
//    [[SSApi sharedApi] getLoggedInWithUsername:@"toto" andPassword:@"toto" withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        
//    }];
//    
//}
//- (IBAction)testComments:(id)sender {
////    [[SSApi sharedApi] getCommentsFromProduct:@"20080563" fromStartIndex:0 withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
////        
////    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
////        
////    }];
//    SSComment *comment = [[SSComment alloc] init];
//    comment.content = @"Nathan me les brises";
//    comment.date = @"05/06/2013";
//    comment.author = @"toto";
//    
//    SSPrice *price = [[SSPrice alloc] init];
//    price.value = [NSNumber numberWithDouble:2.34];
//    price.location = @"49.41568:2.81774";
//    
//    [[SSApi sharedApi] rateProduct:@"20080563" withRate:@"3" andComment:comment withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        
//    }];
//}
//- (IBAction)testRegister:(id)sender {
//    [[SSApi sharedApi] registerWithUsername:@"karim" password:@"karim" mail:@"karim271290@yopmail.com" age:22 andJob:@"student" withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        
//    }];
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [history count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSProfileViewCell *cell = (SSProfileViewCell *)[tableView dequeueReusableCellWithIdentifier:@"historyCell"];
    
    cell.contentLabel.text = [(SSHistory *)[history objectAtIndex:indexPath.row] content];
    cell.typeLabel.text = [(SSHistory *)[history objectAtIndex:indexPath.row] type];
    cell.dateLabel.text = [(SSHistory *)[history objectAtIndex:indexPath.row] date];
    
    return cell;
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

- (NSArray *)loadCustomObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *myEncodedArrayObject = [defaults objectForKey:key];
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSData *object in myEncodedArrayObject) {
        SSHistory *obj = (SSHistory *)[NSKeyedUnarchiver unarchiveObjectWithData: object];
        [result addObject:obj];
    }
    
    return result;
}
@end
