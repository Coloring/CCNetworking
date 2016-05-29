//
//  WHWQuan.m
//  WHWNetWorking
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 Coloring. All rights reserved.
//

#import "ProductModel.h"
#import "AFNetworking.h"
#import "CCNetAPIClient.h"
#import "WHWRequestEncode.h"

@implementation ProductModel

- (instancetype)initProductWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.goodsName = [attributes valueForKeyPath:@"goodsName"];
    self.majorBizId = (NSUInteger)[[attributes valueForKeyPath:@"majorBizId"] integerValue];
    self.remark     = [attributes valueForKeyPath:@"remark"];
    self.price      = (float)[[attributes valueForKeyPath:@"price"] floatValue];
    self.pictureUrl = [attributes valueForKeyPath:@"pictureUrl"];
    return self;
}







@end
