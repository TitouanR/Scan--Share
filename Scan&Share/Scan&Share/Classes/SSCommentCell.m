//
//  SSCommentCell.m
//  
//
//  Created by Titouan Rossier on 01/06/13.
//
//

#import "SSCommentCell.h"

@implementation SSCommentCell

@synthesize contentLabel, authorDateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
