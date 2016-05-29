//
//  WHWNetWorkRequestModel.h
//  WanHuiWang
//
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 Coloring. All rights reserved.
//

#import <Foundation/Foundation.h>

//aes
#import "EncryptAndDecrypt.h"
//sha1
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>










@interface WHWRequestEncode : NSObject


+ (NSDictionary *)sha1EncodeKeysArray: (NSArray *)keysArray valuesArray:(NSArray *)valuesArray;

+ (NSString *)aesAndBase64Encode:(NSString *)code;


+ (NSString *)timeFomatted:(NSInteger)totalSeconds;

+ (NSString *)orderTimeFomatted:(NSInteger)totalSeconds;

+ (NSArray *)imageURLarrayWithJsonString:(NSString *)jsonString;

@end
