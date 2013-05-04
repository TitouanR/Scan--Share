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

@implementation SSApi

static SSApi *sharedApi = nil;

+ (SSApi *)sharedApi
{
    if (!sharedApi){
        sharedApi = [[SSApi alloc] init];
    }
    
    return sharedApi;
}

- (void)getProductWithEAN:(NSString *)eanID
{
    // Create the client
    NSURL *url = [NSURL URLWithString:SSBaseURL];
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:url];
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];

    // Send GET Request and parse results
    [client getPath:[NSString stringWithFormat:@"%@ean/%@", SSBaseURL, eanID] parameters:[NSDictionary dictionaryWithObjectsAndKeys:SSAppKey, @"key", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Operation %@, Mapping : %@", operation, responseObject);
        JSONDecoder* decoder = [[JSONDecoder alloc] init];
        NSDictionary *resultsDictionary = [decoder objectWithData:responseObject];
        NSLog(@"Result %@",resultsDictionary);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Operation %@ Error : %@", operation, error);
    }];
}

@end
