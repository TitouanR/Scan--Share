//
//  SSScanViewController.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 16/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSScanViewController.h"

//Object
#import "SSProduct.h"
#import "SSHistory.h"

//View Controller
#import "SSProductViewController.h"
#import "SSAddProductViewController.h"
@interface SSScanViewController ()

@end


@implementation SSScanViewController

@synthesize readerView, eanToSend;

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
    //Load background
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background@2x.png"]];
    
	// Do any additional setup after loading the view.
    
//    ZBarImageScanner *scanner = [[ZBarImageScanner alloc] init];
//    [scanner setSymbology:ZBAR_EAN13 config:ZBAR_CFG_ENABLE to:0];
//    readerView = [[ZBarReaderView alloc] initWithImageScanner:scanner];
    readerView.readerDelegate = self;
//    readerView.zoom = 1.0;
//    
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [readerView start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ([[segue identifier] isEqualToString:@"fromScanToProductSegue"]) {
        
        // Get the destination view controller
        SSProductViewController *productVC = [segue destinationViewController];
        
        // Get the product to send from (id)sender 
        SSProduct *productToShow =(SSProduct*)sender;
        
        // Set the product object in the destination VC
        [productVC setProduct:productToShow];
    }
    
    else if ([[segue identifier] isEqualToString:@"scanToAddProductPush"]){
        SSAddProductViewController *addProductVC = [segue destinationViewController];
        
        NSString *ean = (NSString*)sender;
        
        [addProductVC setEan:ean];
    }
    
}

#pragma mark -
#pragma mark ZBarView Delegate

- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image
{
       NSString *ean;
  
    for(ZBarSymbol *sym in symbols) {
        ean = sym.data;
        //NSLog(@"code : %@", ean);
        break;
    }
    
    [[SSApi sharedApi] getProductWithEAN:ean withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        SSProduct *product = (SSProduct *)[mappingResult.array objectAtIndex:0];
        
        NSArray *userHistory = (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
        NSMutableArray *history = [NSMutableArray array];
        
        if(userHistory)
        {
            [history addObjectsFromArray:userHistory];
            
        }
        
        SSHistory *historyObject = [[SSHistory alloc] init];
        historyObject.content = product.name;
        historyObject.type = @"Scan";
        historyObject.date = [NSDate date];
        historyObject.scanID = [product ean];
        
        [self saveCustomObjectInHistory:historyObject];
        RKLogInfo(@"Load collection of Products: %@", product);
       [self.readerView stop];
        [self performSegueWithIdentifier:@"fromScanToProductSegue" sender:product];
        
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        if (error.code == -1011){
            eanToSend = ean;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Produit non référencé" message:@"Oups, Scan&Share ne connait pas ce produit, souhaitez-vous l'ajouter ?" delegate:self cancelButtonTitle:@"Non, pas le temps" otherButtonTitles:@"Oui, bien sûr", nil];
            
            [alert show];
            
            
        }else{
            [[SSApi sharedApi] errorHTTPHandler:error];
        }
        
    
    }];
}
- (void)viewDidUnload {
   
    [super viewDidUnload];
}
- (IBAction)testButtonPressed:(id)sender {
    UIButton *sendButton = (UIButton*)sender;
    if (sendButton.tag == 0){
        NSString *ean = @"3068320052007";
        [[SSApi sharedApi] getProductWithEAN:ean withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            SSProduct *product = (SSProduct *)[mappingResult.array objectAtIndex:0];
            RKLogInfo(@"Load collection of Products: %@", product.comments);
            
            
            RKLogInfo(@"Load collection of Products: %@", product);
            
            SSHistory *historyObject = [[SSHistory alloc] init];
            historyObject.content = product.name;
            historyObject.type = @"Scan";
            historyObject.date = [NSDate date];
            historyObject.scanID = ean;
            
            [self saveCustomObjectInHistory:historyObject];
            [self.readerView stop];
            [self performSegueWithIdentifier:@"fromScanToProductSegue" sender:product];
            
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            [[SSApi sharedApi] errorHTTPHandler:error];
            //NSLog(@"Error in getting the data");
        }];
        

    }
    
    else{
        [self performSegueWithIdentifier:@"scanToAddProductPush" sender:nil];
    }
        
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.readerView start];
}

- (void)saveCustomObjectInHistory:(SSHistory *)obj {
    NSArray *userHistory = (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
    NSMutableArray *history = [NSMutableArray array];
    
    if(userHistory)
    {
        [history addObjectsFromArray:userHistory];
        
    }
    
     NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [history addObject:myEncodedObject];
    [[NSUserDefaults standardUserDefaults] setObject:history forKey:@"history"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
        if (buttonIndex == 1) {
            [self performSegueWithIdentifier:@"scanToAddProductPush" sender:eanToSend];
        }

}


@end
