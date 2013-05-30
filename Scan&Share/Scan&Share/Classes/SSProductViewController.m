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

@synthesize product, menu, contentView, scrollView;

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"escheresque_ste.png"]];
    
    
    [scrollView setContentSize:CGSizeMake(320, 832)];
    contentView = [[[NSBundle mainBundle] loadNibNamed:@"SSProductView" owner:self options:nil] objectAtIndex:0];
    
    contentView.backgroundColor  = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background@2x.png"]];
    
    [scrollView addSubview:contentView];
    
    
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
    
    [contentView.nameLabel setText:product.name];

  
}


- (void)viewDidUnload {
   
    [self setScrollView:nil];
    [super viewDidUnload];
}


- (IBAction)testPressed:(id)sender {
    if (menu.isOpen)
        return [menu close];
    
    [menu showFromRect:CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height)
                      inView:self.view];
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"SCROLLL");
}
@end
