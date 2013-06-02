//
//  SSLocation.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 02/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SSLocation : NSObject <MKAnnotation>

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem;

@end
