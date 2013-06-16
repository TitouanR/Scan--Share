//
//  SSAddProductViewController.m
//  
//
//  Created by Titouan Rossier on 12/06/13.
//
//

#import "SSAddProductViewController.h"
#import "SSProduct.h"

@interface SSAddProductViewController ()

@end

@implementation SSAddProductViewController

@synthesize imagePickedPlace, ean, addPictureButton, addProductButton, nameTextField, descTextView, imagePicker, currentLocation, image, priceTextField;

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
    
    //Set up location manager
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) imagePickerController:(UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    image = [[UIImage alloc] init];
    
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imagePickedPlace.image = image;
    
    [addPictureButton setHidden:YES];
    
}

- (IBAction)selectPicture:(id)sender {
    
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = NO;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;

        [self presentViewController:imagePicker animated:YES completion:nil];
    self.imagePicker = nil;
}

- (IBAction)addProduct:(id)sender {
    
    if([self.nameTextField.text isEqualToString:@""] || [self.descTextView.text isEqualToString:@""] || [priceTextField.text isEqualToString:@""] || !image){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Infos manquantes" message:@"Veuillez remplir tous les champs" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
    
        SSProduct *product = [[SSProduct alloc] init];
    
        product.ean = self.ean;
        product.name = self.nameTextField.text;
        product.description = self.descTextView.text;
        NSData *imageData = UIImagePNGRepresentation(image);
        SSImage *imageP = [[SSImage alloc] init];
        imageP.imageBuffer = imageData;
        product.image = imageP;
        
        product.types = [[NSArray alloc] initWithObjects:@"type", nil];
        SSPrice *price = [[SSPrice alloc] init];
        price.location = [NSString stringWithFormat:@"%f:%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];

        
        price.value = [NSNumber numberWithFloat:[priceTextField.text floatValue]];
        product.prices = [[NSMutableArray alloc] initWithObjects:price, nil];
        
        SSPrice *p = [product.prices objectAtIndex:0];
        NSLog(@"%@ : %@",p.value, p.location);
        NSLog(@"Type : %@", [[product types] objectAtIndex:0]);
        
        [[SSApi sharedApi] addProduct:product withCompletionBlockSucceed: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Produit ajouté" message:@"Votre produit à été ajouter" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
        
        
        
    }
}


- (void)viewDidUnload {
    [self setPriceTextField:nil];
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated{
    [locationManager startUpdatingLocation];
}

-(void)viewWillDisappear:(BOOL)animated{
 
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    
    if (!self.currentLocation ){
        self.currentLocation = [[CLLocation alloc] init];
    }
    
    self.currentLocation = location;
    [locationManager stopUpdatingLocation];
}

-(void)dismissKeyboard{
    [nameTextField resignFirstResponder];
    [descTextView resignFirstResponder];
    [priceTextField resignFirstResponder];
}
@end
