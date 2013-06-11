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
#import "SSComment.h"
#import "SSCommentCell.h"
#import "AMRatingControl.h"
#import "SSLoginView.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <CoreLocation/CoreLocation.h>

//Objet
#import "SSProduct.h"

@interface SSProductViewController : UIViewController <SSButtonSubViewProtocol, MFMailComposeViewControllerDelegate,UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate, UIAlertViewDelegate> {
    CLLocationManager *locationManager;
}


//Object
@property (strong, nonatomic) SSProduct *product;


@property (strong, nonatomic) IBOutlet UIScrollView *globalScrollView;

@property (strong, nonatomic) SSProductContentView* contentView;

@property (strong, nonatomic) UIBarButtonItem *showMenuButtonItem;
@property (strong, nonatomic) UIBarButtonItem *addCommentButtonItem;
@property (strong, nonatomic) REMenu *menu;
@property (strong, nonatomic) AMRatingControl *ratingControl;

// Login Popup
@property (strong, nonatomic) IBOutlet SSLoginView *loginView;

- (void)addCommentButtonPressed;
- (IBAction)aroundMe:(id)sender;
- (void)showLoginView;
@end
