//
//  SSAddProductViewController.h
//  
//
//  Created by Titouan Rossier on 12/06/13.
//
//

#import <UIKit/UIKit.h>

@interface SSAddProductViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) NSString *ean;
@property (strong, nonatomic) IBOutlet UIImageView *imagePickedPlace;
@property (strong, nonatomic) IBOutlet UIButton *addPictureButton;
@property (strong, nonatomic) IBOutlet UIButton *addProductButton;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextView *descTextView;

- (IBAction)selectPicture:(id)sender;
-(void)dismissKeyboard;
@end
