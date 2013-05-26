//
//  SSProduct.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 09/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSImage.h"

@interface SSProduct : NSObject

@property (nonatomic, strong) NSString *ean;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) SSImage* image;
@property (nonatomic, strong) NSArray *gps;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) NSArray *prices;

// TO DO : Add Comments

@end