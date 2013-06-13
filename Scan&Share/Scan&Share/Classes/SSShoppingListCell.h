//
//  SSShoppingListCell.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 11/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSShoppingListCell : UITableViewCell <UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIView *selectView;


@end
