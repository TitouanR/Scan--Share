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

@synthesize product, thumbImageView, nameLabel;

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
@end
