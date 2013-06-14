//
//  SSParameterViewController.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 08/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSParameterViewController.h"
#import "ASDepthModalViewController.h"
#import "SSPrice.h"
#import  <QuartzCore/QuartzCore.h>

@interface SSParameterViewController ()

@end

@implementation SSParameterViewController

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
    
    UIImage *buttonImage = [[UIImage imageNamed:@"blueButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    [self.clearHistoryButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setClearHistoryButton:nil];
    [super viewDidUnload];
}



- (IBAction)clearHistory:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"history"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Historique supprimé" message:@"L'historique a été correctement effacé." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)clearShoppingList:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shoppingList"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Liste de course supprimé" message:@"La liste de course a été correctement effacé." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}


@end
