//
//  SSSearchResultViewController.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 31/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSResultList.h"

@interface SSSearchResultViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SSResultList *resultList;

@end
