//
//  SSPrice.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 26/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSPrice.h"

@implementation SSPrice

@synthesize value, location;

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.value forKey:@"value"];
    [encoder encodeObject:self.location forKey:@"location"];

}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.value = [decoder decodeObjectForKey:@"value"];
        self.location = [decoder decodeObjectForKey:@"location"];
    }
    return self;
}
@end
