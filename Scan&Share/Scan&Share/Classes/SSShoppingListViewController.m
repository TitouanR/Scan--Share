//
//  SSShoppingListViewController.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 11/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSShoppingListViewController.h"
#import "SSShoppingListCell.h"
#import "SSShoppingElement.h"
#import "SSProductViewController.h"

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
    for (UIGestureRecognizer *gesture in [cell gestureRecognizers])
    {
        [cell removeGestureRecognizer:gesture];
    }
  
 
    SSShoppingElement *product = (SSShoppingElement *)[self.shoppingList objectAtIndex:indexPath.row];
    cell.productNameLabel.text = product.name;
    cell.priceLabel.text = [NSString stringWithFormat:@"%@€", product.price];
    
    CGRect frame = cell.selectView.frame;
    frame.size.width = 0;
    [cell.selectView setFrame:frame];
    
    if (product.isBought) {
        CGRect frame = cell.selectView.frame;
        frame.size.width += 290;
        [cell.selectView setFrame:frame];
    } 
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction:)];
    UISwipeGestureRecognizer *gestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftGestureAction:)];
    gesture.delegate = self;
    gestureLeft.delegate = self;
    
    [gesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [gestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [cell addGestureRecognizer:gesture];
    [cell addGestureRecognizer:gestureLeft];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SSApi sharedApi] getProductWithEAN:[(SSShoppingElement *)[self.shoppingList objectAtIndex:indexPath.row] ean] withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        SSProduct *product = (SSProduct *)[mappingResult.array objectAtIndex:0];
        [self performSegueWithIdentifier:@"shoppingListToProduct" sender:product];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [[SSApi sharedApi] errorHTTPHandler:error];
    }];
}

- (NSArray *)loadCustomObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *myEncodedArrayObject = [defaults objectForKey:key];
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSData *object in myEncodedArrayObject) {
        SSShoppingElement *obj = (SSShoppingElement *)[NSKeyedUnarchiver unarchiveObjectWithData: object];

        [result addObject:obj];
    }
    
    return result;
}

- (IBAction)getTotal:(id)sender {
    float total = 0;
    
    for(SSShoppingElement *product in self.shoppingList)
    {
        if (![product isBought]) {
             total = total + [product.price floatValue];
        }
       
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Total des courses" message:[NSString stringWithFormat:@"Le total de vos courses est de : %.2f€", total] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)swipeGestureAction:(id)sender {
    UIGestureRecognizer *gestureRecognizer = (UIGestureRecognizer *)sender;
    
    SSShoppingListCell *cell = (SSShoppingListCell *)gestureRecognizer.view;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        
    } else if([gestureRecognizer state] == UIGestureRecognizerStateEnded){
         SSShoppingElement *shoppingElement = [self.shoppingList objectAtIndex:indexPath.row];
        if (!shoppingElement.isBought)
        {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = cell.selectView.frame;
                frame.size.width += 290;
                [cell.selectView setFrame:frame];
            }];
            
            shoppingElement.isBought = YES;
            
            [self modifyCustomObjectInShoppingList:shoppingElement];
        }
    }
}

- (void)swipeLeftGestureAction:(id)sender
{
    UIGestureRecognizer *gestureRecognizer = (UIGestureRecognizer *)sender;
    
    SSShoppingListCell *cell = (SSShoppingListCell *)gestureRecognizer.view;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        
    } else if([gestureRecognizer state] == UIGestureRecognizerStateEnded){
        SSShoppingElement *shoppingElement = [self.shoppingList objectAtIndex:indexPath.row];
        if (shoppingElement.isBought) {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = cell.selectView.frame;
                frame.size.width = 0;
                [cell.selectView setFrame:frame];
            }];
            
            shoppingElement.isBought = NO;
            
            [self modifyCustomObjectInShoppingList:shoppingElement];
        }
    }

}

- (void)modifyCustomObjectInShoppingList:(SSShoppingElement *)obj {
    NSMutableArray *shopping = [NSMutableArray array];
    
    for (SSShoppingElement *shopElt in self.shoppingList)
    {
        NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:shopElt];
        [shopping addObject:myEncodedObject];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:shopping forKey:@"shoppingList"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidUnload {
    [self setGesture:nil];
    [super viewDidUnload];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"shoppingListToProduct"]) {
        // Get the destination view controller
        SSProductViewController *productVC = [segue destinationViewController];
        
        // Get the product to send from (id)sender
        SSProduct *productToShow =(SSProduct*)sender;
        
        // Set the product object in the destination VC
        [productVC setProduct:productToShow];
    }
}
@end
