//
//  SSShoppingListViewController.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 11/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSShoppingListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *shoppingList;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)getTotal:(id)sender;
@end
