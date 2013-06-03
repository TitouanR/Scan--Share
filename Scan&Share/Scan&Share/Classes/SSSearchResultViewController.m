//
//  SSSearchResultViewController.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 31/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSSearchResultViewController.h"
#import "SSSearchResultCell.h"
#import "SSProduct.h"
#import "SSProductViewController.h"
#import "SSMapViewController.h"

@interface SSSearchResultViewController ()

@end

@implementation SSSearchResultViewController

@synthesize resultList;

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
    
    [self.navigationController setHidesBottomBarWhenPushed:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 
#pragma mark - UITableView Methods

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [resultList.result count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSSearchResultCell *cell = (SSSearchResultCell *)[tableView dequeueReusableCellWithIdentifier:@"resultCell"];
    cell.titleLabel.text = [(SSProduct *)[resultList.result objectAtIndex:indexPath.row] name];
    cell.descriptionLabel.text = [(SSProduct *)[resultList.result objectAtIndex:indexPath.row] description];
    
    NSURL *imageURL = [NSURL URLWithString:[[((SSProduct *)[resultList.result objectAtIndex:indexPath.row]) image] imageURL]];
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    NSLog(@"Image : %@", data);
    [cell.productImageView setImage:[UIImage imageWithData:data]];
     
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"resultToProductPush" sender:[resultList.result objectAtIndex:indexPath.row]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"resultToProductPush"]) {
        
        // Get the destination view controller
        SSProductViewController *productViewController = [segue destinationViewController];
        
        // Get the product to send from (id)sender
        SSProduct *productToShow =(SSProduct*)sender;
        
        // Set the product object in the destination VC
        productViewController.product = productToShow;
    }
    
}

@end
