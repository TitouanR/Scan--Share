//
//  SSShoppingElement.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 13/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSImage.h"

@interface SSShoppingElement : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ean;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) BOOL isBought;


@end
