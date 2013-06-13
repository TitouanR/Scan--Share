//
//  SSShoppingListViewController.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 11/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSShoppingListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *shoppingList;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *gesture;

- (IBAction)getTotal:(id)sender;
- (void)swipeGestureAction:(id)sender;
- (void)swipeLeftGestureAction:(id)sender;

@end
