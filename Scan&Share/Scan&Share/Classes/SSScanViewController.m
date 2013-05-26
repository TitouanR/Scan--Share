//
//  SSScanViewController.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 16/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSScanViewController.h"

@interface SSScanViewController ()

@end


@implementation SSScanViewController

@synthesize readerView;

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
    
    ZBarImageScanner *scanner = [[ZBarImageScanner alloc] init];
    [scanner setSymbology:ZBAR_EAN13 config:ZBAR_CFG_ENABLE to:0];
    readerView = [[ZBarReaderView alloc] initWithImageScanner:scanner];
    readerView.readerDelegate = self;
    readerView.zoom = 1.0;
    
    
    [readerView start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark ZBarView Delegate

- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image
{
    
}
@end
