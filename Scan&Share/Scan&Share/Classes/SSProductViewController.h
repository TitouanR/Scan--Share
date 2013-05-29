//
//  SSProductViewController.h
//  Scan&Share
//
//  Created by Titouan Rossier on 29/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>

//Objet
#import "SSProduct.h"

@interface SSProductViewController : UIViewController

//Object
@property (strong, nonatomic) SSProduct *product;

//UI Component
@property (strong, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end
