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
#import "SSComment.h"
#import "SSPrice.h"
#import "SSResultList.h"
#import "SSAppDelegate.h"

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
    
    // Product Mapping (Root element from JSON)
    RKObjectMapping *productMapping = [RKObjectMapping mappingForClass:[SSProduct class]];
    [productMapping addAttributeMappingsFromDictionary:@{
     @"ean": @"ean",
     @"name": @"name",
     @"description": @"description",
     @"rating": @"rating",
     @"types": @"types"}];
    
    // Image Mapping (Internal JSON in JSON)
    RKObjectMapping *imageMapping = [RKObjectMapping mappingForClass:[SSImage class]];
    [imageMapping addAttributeMappingsFromDictionary:@{@"url": @"imageURL",
     @"buffer":@"imageBuffer"}];
    
    // Comments Mapping (Internal Array of JSON)
    RKObjectMapping *commentMapping = [RKObjectMapping mappingForClass:[SSComment class]];
    [commentMapping addAttributeMappingsFromDictionary:@{@"name": @"author", @"content" : @"content", @"date" : @"date"}];
    
    // Prices Mapping (Internal Array of JSON)
    RKObjectMapping *priceMapping = [RKObjectMapping mappingForClass:[SSPrice class]];
    [priceMapping addAttributeMappingsFromDictionary:@{@"price": @"value", @"gps" : @"location"}];
    
    [productMapping addRelationshipMappingWithSourceKeyPath:@"prices" mapping:priceMapping];
    [productMapping addRelationshipMappingWithSourceKeyPath:@"comments" mapping:commentMapping];
    [productMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"photo" toKeyPath:@"image" withMapping:imageMapping]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:productMapping pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
   
    // Create url request for asking API
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@product?id=%@", SSBaseURL, eanID]];
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
    
    // Product Mapping (Root element from JSON)
    RKObjectMapping *productMapping = [RKObjectMapping mappingForClass:[SSProduct class]];
    [productMapping addAttributeMappingsFromDictionary:@{
     @"ean": @"ean",
     @"name": @"name",
     @"description": @"description",
     @"rating": @"rating",
     @"types": @"types"}];
    
    // Image Mapping (Internal JSON in JSON)
    RKObjectMapping *imageMapping = [RKObjectMapping mappingForClass:[SSImage class]];
    [imageMapping addAttributeMappingsFromDictionary:@{@"url": @"imageURL",
     @"buffer":@"imageBuffer"}];
    
    // Comments Mapping (Internal Array of JSON)
    RKObjectMapping *commentMapping = [RKObjectMapping mappingForClass:[SSComment class]];
    [commentMapping addAttributeMappingsFromDictionary:@{@"name": @"author", @"content" : @"content", @"date" : @"date"}];
    
    // Prices Mapping (Internal Array of JSON)
    RKObjectMapping *priceMapping = [RKObjectMapping mappingForClass:[SSPrice class]];
    [priceMapping addAttributeMappingsFromDictionary:@{@"price": @"value", @"gps" : @"location"}];
  
    [productMapping addRelationshipMappingWithSourceKeyPath:@"prices" mapping:priceMapping];
    [productMapping addRelationshipMappingWithSourceKeyPath:@"comments" mapping:commentMapping];
    [productMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"photo" toKeyPath:@"image" withMapping:imageMapping]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:productMapping pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // Create url request for asking API
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@product?id=%@", SSBaseURL, eanID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    // Set blocks for request response
    [objectRequestOperation setCompletionBlockWithSuccess:success failure:failure];
    
    // Launch request
    [objectRequestOperation start];
}

- (void)searchProductWithName:(NSString *)name withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                  failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    // Create mapping between JSON and Objective-C class
    
    // Result Mapping (Root element from JSON)
    RKObjectMapping *resultMapping = [RKObjectMapping mappingForClass:[SSResultList class]];
   
    
    // Product Mapping 
    RKObjectMapping *productMapping = [RKObjectMapping mappingForClass:[SSProduct class]];
    [productMapping addAttributeMappingsFromDictionary:@{
     @"ean": @"ean",
     @"name": @"name",
     @"description": @"description",
     @"rating": @"rating",
     @"types": @"types"}];
    
    // Image Mapping (Internal JSON in JSON)
    RKObjectMapping *imageMapping = [RKObjectMapping mappingForClass:[SSImage class]];
    [imageMapping addAttributeMappingsFromDictionary:@{@"url": @"imageURL",
     @"buffer":@"imageBuffer"}];
    
    // Comments Mapping (Internal Array of JSON)
    RKObjectMapping *commentMapping = [RKObjectMapping mappingForClass:[SSComment class]];
    [commentMapping addAttributeMappingsFromDictionary:@{@"name": @"author", @"content" : @"content", @"date" : @"date"}];
    
    // Prices Mapping (Internal Array of JSON)
    RKObjectMapping *priceMapping = [RKObjectMapping mappingForClass:[SSPrice class]];
    [priceMapping addAttributeMappingsFromDictionary:@{@"price": @"value", @"gps" : @"location"}];
    
    [productMapping addRelationshipMappingWithSourceKeyPath:@"prices" mapping:priceMapping];
    [productMapping addRelationshipMappingWithSourceKeyPath:@"comments" mapping:commentMapping];
    [productMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"photo" toKeyPath:@"image" withMapping:imageMapping]];
    
    [resultMapping addRelationshipMappingWithSourceKeyPath:@"result" mapping:productMapping];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:resultMapping pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // Create url request for asking API
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@product?name=%@", SSBaseURL, name]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    // Set blocks for request response
    [objectRequestOperation setCompletionBlockWithSuccess:success failure:failure];
    // Launch request
    [objectRequestOperation start];
}

- (void)searchProductWithType:(NSString *)type withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                      failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    // Create mapping between JSON and Objective-C class
    
    // Result Mapping (Root element from JSON)
    RKObjectMapping *resultMapping = [RKObjectMapping mappingForClass:[SSResultList class]];
    
    
    // Product Mapping
    RKObjectMapping *productMapping = [RKObjectMapping mappingForClass:[SSProduct class]];
    [productMapping addAttributeMappingsFromDictionary:@{
     @"ean": @"ean",
     @"name": @"name",
     @"description": @"description",
     @"rating": @"rating",
     @"types": @"types"}];
    
    // Image Mapping (Internal JSON in JSON)
    RKObjectMapping *imageMapping = [RKObjectMapping mappingForClass:[SSImage class]];
    [imageMapping addAttributeMappingsFromDictionary:@{@"url": @"imageURL",
     @"buffer":@"imageBuffer"}];
    
    // Comments Mapping (Internal Array of JSON)
    RKObjectMapping *commentMapping = [RKObjectMapping mappingForClass:[SSComment class]];
    [commentMapping addAttributeMappingsFromDictionary:@{@"name": @"author", @"content" : @"content", @"date" : @"date"}];
    
    // Prices Mapping (Internal Array of JSON)
    RKObjectMapping *priceMapping = [RKObjectMapping mappingForClass:[SSPrice class]];
    [priceMapping addAttributeMappingsFromDictionary:@{@"price": @"value", @"gps" : @"location"}];
    
    [productMapping addRelationshipMappingWithSourceKeyPath:@"prices" mapping:priceMapping];
    [productMapping addRelationshipMappingWithSourceKeyPath:@"comments" mapping:commentMapping];
    [productMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"photo" toKeyPath:@"image" withMapping:imageMapping]];
    
    [resultMapping addRelationshipMappingWithSourceKeyPath:@"result" mapping:productMapping];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:resultMapping pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // Create url request for asking API
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@product?type=%@", SSBaseURL, type]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    // Set blocks for request response
    [objectRequestOperation setCompletionBlockWithSuccess:success failure:failure];
    // Launch request
    [objectRequestOperation start];
}


- (void)getLoggedInWithUsername:(NSString *)name andPassword:(NSString *)password withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                      failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
#warning Change Token TO DO : Add Mapping
    // Create the base URL
    NSURL *url = [NSURL URLWithString:SSBaseURL];
    // Setting response content type
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/plain"];
    
    // Setting POST Request
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:url];
    NSString *token = [[NSString alloc] init];
    [manager getObject:token path:[NSString stringWithFormat:@"%@login?username=%@&password=%@", SSBaseURL, name, password] parameters:nil success:success failure:failure];
    
}

- (void)getCommentsFromProduct:(NSString *)ean fromStartIndex:(int)index withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                      failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    // Create mapping between JSON and Objective-C class
    
    // Result Mapping (Root element from JSON)
    RKObjectMapping *resultMapping = [RKObjectMapping mappingForClass:[SSComment class]];

    // Comments Mapping (Internal Array of JSON)
    RKObjectMapping *commentMapping = [RKObjectMapping mappingForClass:[SSComment class]];
    [commentMapping addAttributeMappingsFromDictionary:@{@"name": @"author", @"content" : @"content", @"date" : @"date"}];
    
    [resultMapping addRelationshipMappingWithSourceKeyPath:@"comment" mapping:commentMapping];

    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:resultMapping pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // Create url request for asking API
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@product?id=%@&commentsstartindex=%d", SSBaseURL, ean, index]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    // Set blocks for request response
    [objectRequestOperation setCompletionBlockWithSuccess:success failure:failure];
    // Launch request
    [objectRequestOperation start];
}

- (void)getSalesFromProduct:(NSString *)ean withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                       failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
//    // Create mapping between JSON and Objective-C class
//    
//    // Result Mapping (Root element from JSON)
//    RKObjectMapping *resultMapping = [RKObjectMapping mappingForClass:[SSComment class]];
//    
//    // Comments Mapping (Internal Array of JSON)
//    RKObjectMapping *commentMapping = [RKObjectMapping mappingForClass:[SSComment class]];
//    [commentMapping addAttributeMappingsFromDictionary:@{@"name": @"author", @"content" : @"content", @"date" : @"date"}];
//    
//    [resultMapping addRelationshipMappingWithSourceKeyPath:@"comment" mapping:commentMapping];
//    
//    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:resultMapping pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//    
//    // Create url request for asking API
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@product?id=%@&commentsstartindex=%d", SSBaseURL, ean, index]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
//    
//    // Set blocks for request response
//    [objectRequestOperation setCompletionBlockWithSuccess:success failure:failure];
//    // Launch request
//    [objectRequestOperation start];
}

/**
  * POST Methods
 **/

- (void)registerWithUsername:(NSString *)name
                        password:(NSString *)password
                        mail:(NSString *)email
                        age:(int)age
                        andJob:(NSString *)job
                    withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                        failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    // Create url request for asking API
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@register", SSBaseURL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@&email=%@&age=%d&job=%@", name, password, email, age, job];
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"application/json"];
    
    RKResponseDescriptor *responseDescriptor = [[RKResponseDescriptor alloc] init];

    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    // Set blocks for request response
    [objectRequestOperation setCompletionBlockWithSuccess:success failure:failure];
    // Launch request
    [objectRequestOperation start];
}

- (void)rateProduct:(NSString *)ean withRate:(NSString *)rate andComment:(SSComment *)comment
  withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                     failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    // Create the base URL
   NSURL *url = [NSURL URLWithString:SSBaseURL];
    // Setting response content type
  [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/plain"];
    
    // Setting POST Request
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:url];
    SSAppDelegate *appDelegate = (SSAppDelegate *)[UIApplication sharedApplication].delegate;
    [manager postObject:nil path:[NSString stringWithFormat:@"product?id=%@&comment&token=%@", ean, appDelegate.currentLoggedAccount.token] parameters:@{@"rating":rate, @"comment[name]":comment.author, @"comment[date]":comment.date, @"comment[content]":comment.content}  success:success failure:failure];
}

- (void)modifyProduct:(NSString *)ean withPrice:(SSPrice *)price withCompletionBlockSucceed:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
            failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    // Create the base URL
    NSURL *url = [NSURL URLWithString:SSBaseURL];
    // Setting response content type
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/plain"];
    
    // Setting POST Request
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:url];
    [manager postObject:nil path:[NSString stringWithFormat:@"product?id=%@&price", ean] parameters:@{@"price":price.value, @"gps":price.location}  success:success failure:failure];
}

@end
