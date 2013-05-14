//
//  SSProduct.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 09/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSProduct.h"

@implementation SSProduct

@synthesize titles;
@synthesize brands;
@synthesize imageURL;

- (NSString *)title
{
    return (titles ? [titles objectAtIndex:0] : nil);
}

- (NSString *)brand
{
    return (brands ? [brands objectAtIndex:0] : nil);
}

@end
