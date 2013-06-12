//
//  SSShoppingListViewController.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 11/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSShoppingListViewController.h"
#import "SSShoppingListCell.h"
#import "SSProduct.h"

@interface SSShoppingListViewController ()

@end

@implementation SSShoppingListViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    self.shoppingList = [self loadCustomObjectWithKey:@"shoppingList"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.shoppingList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSShoppingListCell *cell = (SSShoppingListCell *)[tableView dequeueReusableCellWithIdentifier:@"shoppingListCell"];
    SSProduct *product = (SSProduct *)[self.shoppingList objectAtIndex:indexPath.row];
   
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:product.image.imageURL]];
    [cell.imageView setImage:[UIImage imageWithData:data]];
    cell.productNameLabel.text = product.name;
    cell.priceLabel.text = [NSString stringWithFormat:@"%.2f€", product.getPricesMean];
    
    return cell;
}

- (NSArray *)loadCustomObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *myEncodedArrayObject = [defaults objectForKey:key];
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSData *object in myEncodedArrayObject) {
        SSProduct *obj = (SSProduct *)[NSKeyedUnarchiver unarchiveObjectWithData: object];
        [result addObject:obj];
    }
    
    return result;
}

- (IBAction)getTotal:(id)sender {
    float total = 0;
    
    for(SSProduct *product in self.shoppingList)
    {
        total = total + product.getPricesMean;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Total des courses" message:[NSString stringWithFormat:@"Le total de vos courses est de : %.2f€", total] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}
@end
