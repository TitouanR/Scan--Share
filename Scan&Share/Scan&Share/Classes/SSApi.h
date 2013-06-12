//
//  SSApi.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 03/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSComment, SSPrice;

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
- (void)searchProductWithType:(NSString *)type withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                      failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;
- (void)getLoggedInWithUsername:(NSString *)name andPassword:(NSString *)password withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                        failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;
- (void)getCommentsFromProduct:(NSString *)ean fromStartIndex:(int)index withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                       failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

// POST
- (void)registerWithUsername:(NSString *)name
                    password:(NSString *)password
                        mail:(NSString *)email
                         age:(int)age
                      andJob:(NSString *)job
  withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                     failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

- (void)rateProduct:(NSString *)ean withRate:(NSString *)rate andComment:(SSComment *)comment
withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
            failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

- (void)modifyProduct:(NSString *)ean withPrice:(SSPrice *)price withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

// ERRORS

- (void)errorHTTPHandler:(NSError *)error;

@end
