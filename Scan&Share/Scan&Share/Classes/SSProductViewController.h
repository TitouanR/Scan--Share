//
//  SSProductViewController.h
//  Scan&Share
//
//  Created by Titouan Rossier on 29/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REMenu.h"
#import "SSProductContentView.h"


//Objet
#import "SSProduct.h"

@interface SSProductViewController : UIViewController <UIScrollViewDelegate>

//Object
@property (strong, nonatomic) SSProduct *product;


@property (strong, nonatomic) IBOutlet UIScrollView *globalScrollView;

@property (strong, nonatomic) SSProductContentView* contentView;


@property (strong, nonatomic) REMenu *menu;
- (IBAction)testPressed:(id)sender;

@end
