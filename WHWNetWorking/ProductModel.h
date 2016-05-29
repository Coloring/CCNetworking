//
//  WHWQuan.h
//  WHWNetWorking
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 Coloring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject

@property (nonatomic, assign) NSUInteger productId;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, assign) NSUInteger majorBizId;
@property (nonatomic, strong) NSString *pictureUrl;
@property (nonatomic, assign) float price;
@property (nonatomic, strong) NSString *remark;



- (instancetype)initProductWithAttributes:(NSDictionary *)attributes;





@end
