//
//  SSProductContentView.m
//  Scan&Share
//
//  Created by Titouan Rossier on 30/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSProductContentView.h"

@implementation SSProductContentView

@synthesize nameLabel, thumbImage, commentsTable, delegate, commentCellNib, descriptionTextView, rateLabel, pictoRateImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
            }
    return self;
}

- (IBAction)commentsButtonPressed:(id)sender {
    NSLog(@"COMMENTS BUTTON PRESSED IN SUBVIEW");
    [self.delegate buttonClicked:(UIButton*)sender inView:self];
}

- (IBAction)rateButtonClicked:(id)sender {
    
    [self.delegate buttonClicked:(UIButton*)sender inView:self];

}
@end
