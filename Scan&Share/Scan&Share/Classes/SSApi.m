//
//  SSApi.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 03/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSApi.h"
#import <RestKit/RestKit.h>
#import "JSONKit.h"
#import "SSProduct.h"
#import "SSImage.h"
@implementation SSApi

static SSApi *sharedApi = nil;

+ (SSApi *)sharedApi
{
    if (!sharedApi){
        sharedApi = [[SSApi alloc] init];
    }
    
    return sharedApi;
}

/**
  * Method name : getProductWithEAN:eanID
  * Description : send GET Request to ask API about an EAN Code and get product result
 **/

- (void)getProductWithEAN:(NSString *)eanID
{
    // Create mapping between JSON and Objective-C class
    RKObjectMapping *productMapping = [RKObjectMapping mappingForClass:[SSProduct class]];
    [productMapping addAttributeMappingsFromDictionary:@{
     @"ean": @"ean",
     @"name": @"name",
     @"description": @"description",
     @"rating": @"rating",
     @"gps": @"gps",
     @"types": @"types",
     @"prices": @"prices"}];
    
    RKObjectMapping *imageMapping = [RKObjectMapping mappingForClass:[SSImage class]];
    [imageMapping addAttributeMappingsFromDictionary:@{@"url": @"imageURL",
    @"buffer":@"imageBuffer"}];
    
    [productMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"photo" toKeyPath:@"image" withMapping:imageMapping]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:productMapping pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
   
    // Create url request for asking API
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@ean?id=%@", SSBaseURL, eanID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    // Set blocks for request response
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        SSProduct *product = (SSProduct *)[mappingResult.array objectAtIndex:0];
        RKLogInfo(@"Load collection of Products: %@", product);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    

    // Launch request
    [objectRequestOperation start];
}

- (void)getProductWithEAN:(NSString *)eanID withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                  failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    // Create mapping between JSON and Objective-C class
    RKObjectMapping *productMapping = [RKObjectMapping mappingForClass:[SSProduct class]];
    [productMapping addAttributeMappingsFromDictionary:@{
     @"ean": @"ean",
     @"name": @"name",
     @"description": @"description",
     @"rating": @"rating",
     @"gps": @"gps",
     @"types": @"types",
     @"prices": @"prices"}];
    
    RKObjectMapping *imageMapping = [RKObjectMapping mappingForClass:[SSProduct class]];
    [imageMapping addAttributeMappingsFromDictionary:@{@"url": @"imageURL",
     @"buffer":@"imageBuffer"}];
    
    [productMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"photo" toKeyPath:@"imageURL" withMapping:imageMapping]];
    [productMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"photo" toKeyPath:@"imageBuffer" withMapping:imageMapping]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:productMapping pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // Create url request for asking API
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@ean?id=%@", SSBaseURL, eanID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    // Set blocks for request response
    [objectRequestOperation setCompletionBlockWithSuccess:success failure:failure];
    
    // Launch request
    [objectRequestOperation start];
}

@end