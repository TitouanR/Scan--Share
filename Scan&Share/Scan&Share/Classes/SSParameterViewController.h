//
//  SSParameterViewController.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 08/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SSParameterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *clearHistoryButton;

- (IBAction)clearHistory:(id)sender;

@end
