//
//  SSShoppingElement.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 13/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSShoppingElement.h"

@implementation SSShoppingElement

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.ean forKey:@"ean"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.price forKey:@"price"];
    [encoder encodeBool:self.isBought forKey:@"isBought"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.ean = [decoder decodeObjectForKey:@"ean"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.price = [decoder decodeObjectForKey:@"price"];
        self.isBought = [decoder decodeBoolForKey:@"isBought"];
    }
    return self;
}

@end
