//
//  SSProduct.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 09/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSProduct : NSObject

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *brands;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *imageURL;

@end
