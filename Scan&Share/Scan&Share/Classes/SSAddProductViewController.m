//
//  SSAddProductViewController.m
//  
//
//  Created by Titouan Rossier on 12/06/13.
//
//

#import "SSAddProductViewController.h"

@interface SSAddProductViewController ()

@end

@implementation SSAddProductViewController

@synthesize imagePickedPlace, ean, addPictureButton, addProductButton, nameTextField, descTextView;

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
    
    //Load background
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background@2x.png"]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    UIImage *buttonImage = [[UIImage imageNamed:@"blueButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"blueButtonHighlight"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    
    [addProductButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
     [addProductButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) imagePickerController:(UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    UIImage* image = [[UIImage alloc] init];
    
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imagePickedPlace.image = image;
    
    [addPictureButton setHidden:YES];
    
}

- (IBAction)selectPicture:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)viewDidUnload {
 
    [super viewDidUnload];
}

-(void)dismissKeyboard{
    [nameTextField resignFirstResponder];
    [descTextView resignFirstResponder];
}
@end
