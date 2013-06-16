//
//  SSAddCommentViewController.h
//  
//
//  Created by Titouan Rossier on 04/06/13.
//
//

#import <UIKit/UIKit.h>
#import "AMRatingControl.h"
#import "SSComment.h" 

@interface SSAddCommentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *commentTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) NSString *ean;
@property (strong, nonatomic) NSString* rate;
@property (strong, nonatomic) SSComment* commentToSend;

- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardDidHide:(NSNotification *)notification;
-(void)dismissKeyboard;
- (IBAction)sendComment:(id)sender;

@end
