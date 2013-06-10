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
#import "SSProduct.h"
#import "SSProductViewController.h"
#import "SSResultList.h"
#import "SSSearchResultViewController.h"
#import "ASDepthModalViewController.h"

@interface SSProfileViewController ()

@end

@implementation SSProfileViewController

@synthesize history;

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

- (void)viewWillAppear:(BOOL)animated
{
    [self reloadData];
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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yy"];
    NSString *showDate = [dateFormatter stringFromDate:[(SSHistory *)[history objectAtIndex:indexPath.row] date]];
    cell.dateLabel.text = showDate;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSHistory *historyObject = [history objectAtIndex:indexPath.row];
    if ([historyObject.type isEqualToString:@"Scan"]) {
        if(historyObject.scanID)
        {
            [[SSApi sharedApi] getProductWithEAN:historyObject.scanID withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                SSProduct *product = (SSProduct *)[mappingResult.array objectAtIndex:0];
                [self performSegueWithIdentifier:@"historyToProductPush" sender:product];
            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                
            }];
        }

    } else if ([historyObject.type isEqualToString:@"NameSearch"]){
        [[SSApi sharedApi] searchProductWithName:historyObject.content withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            SSResultList *resultList = (SSResultList *)[mappingResult.array objectAtIndex:0];
            [self performSegueWithIdentifier:@"historyToResultPush" sender:resultList];
            
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            
        }];
    }
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

- (void)reloadData
{
    history = [self loadCustomObjectWithKey:@"history"];
    
    [self.tableView reloadData];
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



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ([[segue identifier] isEqualToString:@"historyToProductPush"]) {
        
        // Get the destination view controller
        SSProductViewController *productVC = [segue destinationViewController];
        
        // Get the product to send from (id)sender
        SSProduct *productToShow =(SSProduct*)sender;
        
        // Set the product object in the destination VC
        [productVC setProduct:productToShow];
    } else if ([[segue identifier] isEqualToString:@"historyToResultPush"]) {
        SSSearchResultViewController *resultViewController = [segue destinationViewController];
        SSResultList *resultList = (SSResultList *)sender;
        resultViewController.resultList = resultList;
    }
    
}

- (IBAction)showLoginView:(id)sender {
    
    UIColor *color = nil;
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    ASDepthModalOptions options = style | ASDepthModalOptionBlurNone;
    
    [ASDepthModalViewController presentView:self.loginView backgroundColor:color options:options completionHandler:^{
        
    }];
    
}

@end
