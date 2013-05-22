//
//  SSImage.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 22/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSImage : NSObject

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSData *imageBuffer;

@end
