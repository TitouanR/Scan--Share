//
//  SSApi.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 03/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SSApi : NSObject

+ (SSApi *)sharedApi;

/**
  * This class provides high level API for Webservices communication
 **/

- (void)getProductWithEAN:(NSString *)eanID;
- (void)getProductWithEAN:(NSString *)eanID withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                  failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

- (void)searchProductWithName:(NSString *)name withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                      failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

@end
