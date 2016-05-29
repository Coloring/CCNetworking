//
//  WHWNetWorkRequestModel.m
//  WanHuiWang
//
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 Coloring. All rights reserved.
//

#import "WHWRequestEncode.h"

#import "NSString+URL.h"


@implementation WHWRequestEncode


+ (NSDictionary *)sha1EncodeKeysArray: (NSArray *)keysArray valuesArray:(NSArray *)valuesArray {
    
    NSString *key_sha1 = [self sha1Key];
    
    NSMutableArray *keyMuArr = [[NSMutableArray alloc] initWithArray:keysArray];
    NSMutableArray *valMyArr = [[NSMutableArray alloc] initWithArray:valuesArray];

    
    NSMutableArray *valMyArr_UTF8 = [[NSMutableArray alloc] initWithCapacity:10];
    
    
    for (NSInteger i = 0; i < valMyArr.count; i++) {
         [valMyArr_UTF8 addObject: [valMyArr[i] URLEncodedString]];      //第二种方法a
    }

    
    NSString *signitureStr = [[NSString alloc] init];
    
    for (NSInteger i = 0; i < keyMuArr.count; i ++) {
        signitureStr = [signitureStr stringByAppendingFormat:@"%@=%@&", [keyMuArr objectAtIndex:i], [valMyArr_UTF8 objectAtIndex:i] ];
        
 //       NSLog(@"%@", signitureStr);
        
    }
    

    
    signitureStr = [signitureStr stringByAppendingFormat:@"key=%@", key_sha1];

    
  //  NSLog(@"----------%@", signitureStr);
    
    NSString *signitureStr_sha1 = [self sha1:signitureStr];
    
    [valMyArr_UTF8 addObject:signitureStr_sha1];
    [keyMuArr addObject:@"signiture"];
    
    NSDictionary *bodyDic = [NSDictionary dictionaryWithObjects:valMyArr_UTF8 forKeys:keyMuArr];
    
    return bodyDic;
}


+ (NSString *)aesAndBase64Encode:(NSString *)code {
    
    NSData *code_Data = [code dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [self aesKeyData];
    NSData *code_AES = [code_Data AES256EncryptWithKey:keyData];
    NSString *code_AES_Base64 = [code_AES base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return code_AES_Base64;
}



#pragma mark - sha1 算法
+ (NSString *) sha1:(NSString *)input {
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (signed int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}



+ (NSString *)sha1Key {
    NSString *key_sha1 = @"123";
    return key_sha1;
}

+ (NSData *)aesKeyData {

    Byte keyByte[] = {0x08,0x08,0x04,0x0b,0x02,0x0f,0x0b,0x0c,0x01,0x03,0x09,0x07,0x0c,0x03,
        0x07,0x0a,0x04,0x0f,0x06,0x0f,0x0e,0x09,0x05,0x01,0x0a,0x0a,0x01,0x09,
        0x06,0x07,0x09,0x0d};

    NSData *keyData = [[NSData alloc] initWithBytes:keyByte length:32];

    return keyData;
}








+ (NSString *)timeFomatted:(NSInteger)totalSeconds {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:totalSeconds];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    NSString *dateStr = [dateFormatter stringFromDate:localDate];

    return dateStr;
}

+ (NSString *)orderTimeFomatted:(NSInteger)totalSeconds {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:totalSeconds];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateStr = [dateFormatter stringFromDate:localDate];
    
    return dateStr;
}

+ (NSArray *)imageURLarrayWithJsonString:(NSString *)jsonString {

    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonDate = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonDate options:NSJSONReadingMutableContainers error:&err];
    
    if (err) {
        return nil;
    }
    
    return arr;
}





@end
