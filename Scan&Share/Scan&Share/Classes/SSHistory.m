//
//  SSHistory.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 07/06/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSHistory.h"

@implementation SSHistory

@synthesize content, date, type, scanID;

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.content forKey:@"content"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.scanID forKey:@"scanID"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.content = [decoder decodeObjectForKey:@"content"];
        self.date = [decoder decodeObjectForKey:@"date"];
        self.type = [decoder decodeObjectForKey:@"type"];
        self.scanID = [decoder decodeObjectForKey:@"scanID"];
}
    return self;
}

@end
