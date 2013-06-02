//
//  SSMapViewController.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 02/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSMapViewController.h"
#import <MapKit/MapKit.h>
#import "SSLocation.h"
#import "SSPrice.h"

@interface SSMapViewController ()

@end

@implementation SSMapViewController

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
    
    [self plotProductPositions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}

- (void)plotProductPositions
{
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    for(SSPrice *price in self.product.prices)
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        
        if([price location])
        {
            // Example for test
            // price.location = @"49.41568:2.81774";
            NSNumber *latitude = [numberFormatter numberFromString:[[price.location componentsSeparatedByString:@":"] objectAtIndex:0]];
            NSNumber *longitude = [numberFormatter numberFromString:[[price.location componentsSeparatedByString:@":"] objectAtIndex:1]];
            
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = latitude.doubleValue;
            coordinate.longitude = longitude.doubleValue;
           
            SSLocation *annotation = [[SSLocation alloc] initWithName:@"" address:@"" coordinate:coordinate] ;
            [_mapView addAnnotation:annotation];
        }
	}

}

@end
