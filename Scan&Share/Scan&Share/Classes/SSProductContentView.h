//
//  SSProductContentView.h
//  Scan&Share
//
//  Created by Titouan Rossier on 30/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSButtonSubViewProtocol.h"
@interface SSProductContentView : UIView

@property (nonatomic, strong) id<SSButtonSubViewProtocol> delegate;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *rateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *thumbImage;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIImageView *pictoRateImage;
@property (strong, nonatomic) IBOutlet UIButton *rateButton;

@property (strong, nonatomic) IBOutlet UITableView *commentsTable;

@property (strong, nonatomic) UINib *commentCellNib;
- (IBAction)commentsButtonPressed:(id)sender;
- (IBAction)rateButtonClicked:(id)sender;

@end
