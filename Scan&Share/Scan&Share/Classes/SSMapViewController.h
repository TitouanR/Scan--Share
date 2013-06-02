//
//  SSMapViewController.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 02/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SSProduct.h"

@interface SSMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) SSProduct *product;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;


@end
