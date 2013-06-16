//
//  SSProduct.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 09/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSImage.h"
#import "SSPrice.h"

@interface SSProduct : NSObject

// Déclaration de variables et génération des getters/setters

@property (nonatomic, strong) NSString *ean;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) SSImage* image;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) NSMutableArray *prices;

// Déclaration des méthodes

-(SSPrice*)getMinimumPrice;
-(SSPrice*)getMaximumPrice;
-(float)getPricesMean;

@end
