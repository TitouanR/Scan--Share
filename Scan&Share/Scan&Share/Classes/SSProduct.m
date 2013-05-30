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
    return NULL;
}
-(SSPrice*)getMaximumPrice{
    return NULL;
}
-(SSPrice*)getPricesMean{
    return NULL;
}

@end
