//
//  SSAddProductViewController.h
//  
//
//  Created by Titouan Rossier on 12/06/13.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SSAddProductViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}


@property (strong, nonatomic) NSString *ean;
@property (strong, nonatomic) IBOutlet UIImageView *imagePickedPlace;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) IBOutlet UIButton *addPictureButton;
@property (strong, nonatomic) IBOutlet UIButton *addProductButton;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextView *descTextView;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) UIImage* image;
- (IBAction)selectPicture:(id)sender;
- (IBAction)addProduct:(id)sender;
-(void)dismissKeyboard;
@end
