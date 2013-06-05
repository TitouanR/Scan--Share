//
//  SSAddCommentViewController.h
//  
//
//  Created by Titouan Rossier on 04/06/13.
//
//

#import <UIKit/UIKit.h>
#import "AMRatingControl.h"

@interface SSAddCommentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *commentTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardDidHide:(NSNotification *)notification;
-(void)dismissKeyboard;
- (IBAction)sendComment:(id)sender;

@end
