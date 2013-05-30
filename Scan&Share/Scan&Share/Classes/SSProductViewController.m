//
//  SSProductViewController.m
//  Scan&Share
//
//  Created by Titouan Rossier on 29/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSProductViewController.h"



@interface SSProductViewController ()

@end

@implementation SSProductViewController

@synthesize product, thumbImageView, nameLabel, menu;

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
    
    //Load Background
     self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background@2x.png"]];
    
    REMenuItem *addToListItem = [[REMenuItem alloc] initWithTitle:@"Ajouter à ma liste"
                                                    subtitle:@"Pour faciliter vos courses"
                                                       image:[UIImage imageNamed:@"addToListIco.png"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
                                                      }];
    
    REMenuItem *shareItem = [[REMenuItem alloc] initWithTitle:@"Partager"
                                                       subtitle:@"Sur vos réseaux sociaux préférés"
                                                          image:[UIImage imageNamed:@"Icon_Explore"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                         }];
    
    REMenuItem *showOccasions = [[REMenuItem alloc] initWithTitle:@"Voir les occasions"
                                                        subtitle:@""
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              NSLog(@"Item: %@", item);
                                                        
                                                          }];
    
    REMenuItem *addOccasion = [[REMenuItem alloc] initWithTitle:@"Ajouter une occasion"
                                                          image:[UIImage imageNamed:@"Icon_Profile"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                             
                                                         }];
    
    addToListItem.tag = 0;
    shareItem.tag = 1;
    showOccasions.tag = 2;
    addOccasion.tag = 3;
    
    menu = [[REMenu alloc] initWithItems:@[addToListItem, shareItem, showOccasions, addOccasion]];
    menu.cornerRadius = 4;
    menu.shadowRadius = 4;
    menu.shadowColor = [UIColor blackColor];
    menu.shadowOffset = CGSizeMake(0, 1);
    menu.shadowOpacity = 1;
    menu.imageOffset = CGSizeMake(5, -1);
    menu.waitUntilAnimationIsComplete = NO;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    //Set the VC title
    self.title =product.name;
    
    //Set the UI Component of the view with product attributs
    [nameLabel setText:product.name];
    
    
    NSURL *imageUrl = [NSURL URLWithString:product.image.imageURL];
    NSLog(@"URL : %@", imageUrl);
    product.image.imageBuffer = [NSData dataWithContentsOfURL:imageUrl];
    thumbImageView.image = [UIImage imageWithData:product.image.imageBuffer];
}


- (void)viewDidUnload {
    [self setThumbImageView:nil];
    [self setNameLabel:nil];
    [super viewDidUnload];
}


- (IBAction)testPressed:(id)sender {
    if (menu.isOpen)
        return [menu close];
    
    [menu showFromRect:CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height)
                      inView:self.view];
}
@end
