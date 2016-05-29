//
//  CCNetAPIClient.m
//  WHWNetWorking
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 Coloring. All rights reserved.
//

#import "CCNetAPIClient.h"

static NSString *const WHWAppBaseURLstr = @"http://www.wzsale.com";



@implementation CCNetAPIClient

+ (instancetype)sharedClient {
    static CCNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[CCNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:WHWAppBaseURLstr]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.requestSerializer.timeoutInterval = 10.f;
        [_sharedClient.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
    });
    
    return  _sharedClient;
}


@end
