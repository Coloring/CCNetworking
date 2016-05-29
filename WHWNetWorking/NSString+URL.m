//
//  NSString+URL.m
//  WanHuiWang
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 Coloring. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)


- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    
    return encodedString;
}




@end

