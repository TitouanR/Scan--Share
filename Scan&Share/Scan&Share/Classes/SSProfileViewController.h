//
//  SSProfileViewController.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 05/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSLoginView.h"

@interface SSProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *history;
@property (nonatomic, strong) IBOutlet SSLoginView *loginView;

@end
