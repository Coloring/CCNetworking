//
//  ProductServer.m
//  WHWNetWorking
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 Coloring. All rights reserved.
//

#import "ProductServer.h"
#import "AFNetworking.h"
#import "CCNetAPIClient.h"
#import "WHWRequestEncode.h"
#import "ProductModel.h"

@implementation ProductServer

+ (NSURLSessionDataTask *)whwQuanPostsWithBlock:(void (^)(NSArray *posts, NSError *error))block {
    
    NSArray *keyArr = @[@"url"];
    NSArray *valArr = @[@"http://www.wzsale.com/webservice/client/guesslove/list.json"];
    
    
    NSDictionary *dic = [WHWRequestEncode sha1EncodeKeysArray:keyArr valuesArray:valArr];
    
    return [[CCNetAPIClient sharedClient] POST:@"/webservice/client/guesslove/list.json" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        
        NSArray *dataArray = [responseObject objectForKey:@"data"];
        
        NSMutableArray *goodsMutableArray = [[NSMutableArray alloc] initWithCapacity:dataArray.count];
        
        for (NSDictionary *temp in dataArray) {
            ProductModel *product = [[ProductModel alloc] initProductWithAttributes:temp];
            [goodsMutableArray addObject:product];
        }
        
        if (block) {
            block ([NSArray arrayWithArray:goodsMutableArray], nil);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block ([NSArray array], error);
        }
    }];
}



@end
