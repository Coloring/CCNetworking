//
//  ProductServer.h
//  WHWNetWorking
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 Coloring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductServer : NSObject


+ (NSURLSessionDataTask *)whwQuanPostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;


@end
