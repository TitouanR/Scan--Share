//
//  SSProductContentView.m
//  Scan&Share
//
//  Created by Titouan Rossier on 30/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSProductContentView.h"

@implementation SSProductContentView

@synthesize nameLabel, thumbImage, commentsTable, delegate, commentCellNib, descriptionTextView, rateLabel, pictoRateImage, showMapButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
            }
    return self;
}

- (IBAction)buttonPressed:(id)sender{
    [self.delegate buttonClicked:(UIButton*)sender inView:self];
}
@end
