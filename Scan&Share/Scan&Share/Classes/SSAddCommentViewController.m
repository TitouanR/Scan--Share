//
//  SSAddCommentViewController.m
//  
//
//  Created by Titouan Rossier on 04/06/13.
//
//

#import "SSAddCommentViewController.h"

@interface SSAddCommentViewController ()

@end

@implementation SSAddCommentViewController

@synthesize sendButton, commentTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor  = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background@2x.png"]];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"blueButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"blueButtonHighlight"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [sendButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [sendButton setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    
    CGRect newFrame = CGRectMake(0,-50,320,460);
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                       [self.view setFrame:newFrame];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    CGRect initialFrame = CGRectMake(0,0,320,460);
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.view setFrame:initialFrame];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}


- (void)viewDidUnload {
    [self setSendButton:nil];
    [self setCommentTextField:nil];
    [super viewDidUnload];
}

-(void)dismissKeyboard {
    [commentTextField resignFirstResponder];
    [self keyboardDidHide:nil];
}


- (IBAction)sendComment:(id)sender {
    
    //Send Comment
}
@end
