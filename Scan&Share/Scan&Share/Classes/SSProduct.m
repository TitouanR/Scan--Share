//
//  SSProduct.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 09/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSProduct.h"

@implementation SSProduct

@synthesize ean, name, description, image, rating, comments, types, prices;

//TODO
-(SSPrice*)getMinimumPrice{
    
    if ([self.prices count] > 0){
        SSPrice *min = [self.prices objectAtIndex:0];
        
        for (SSPrice *p in self.prices) {
            if (p.value < min.value){
                min = p;
            }
        }
        return min;
    }
        
    return 0;
}

-(SSPrice*)getMaximumPrice{
    
    if ([self.prices count] > 0){
        SSPrice *max = [self.prices objectAtIndex:0];
    
        for (SSPrice *p in self.prices) {
            if (p.value > max.value){
                max = p;
            }
        }
        return max;
    }
    
    return 0;
}


-(float)getPricesMean{
    
    if ([self.prices count] > 0){
        float somme =0;
        for (SSPrice *p in self.prices) {
            somme += [p.value floatValue];
        }
        
        somme /=[self.prices count];
        
        return somme;
    }
    return 0;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.ean forKey:@"ean"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.prices forKey:@"prices"];
    [encoder encodeObject:self.description forKey:@"description"];
    [encoder encodeObject:self.rating forKey:@"rating"];
    [encoder encodeObject:self.comments forKey:@"comments"];
    [encoder encodeObject:self.types forKey:@"types"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.ean = [decoder decodeObjectForKey:@"ean"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.prices = [decoder decodeObjectForKey:@"type"];
        self.description = [decoder decodeObjectForKey:@"description"];
        self.rating = [decoder decodeObjectForKey:@"rating"];
        self.comments = [decoder decodeObjectForKey:@"comments"];
        self.types = [decoder decodeObjectForKey:@"types"];
    }
    return self;
}
@end
