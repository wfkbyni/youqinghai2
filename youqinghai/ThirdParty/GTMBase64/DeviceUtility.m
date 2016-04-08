//
//  DeviceUtility.h
//  RenRen
//
//  Created by Zeng Hao on 15/1/18.
//  Copyright (c) 2015年 Zeng Hao. All rights reserved.
//

#import "DeviceUtility.h"
#import "CommonCrypto/CommonCryptor.h"
#import "GTMBase64.h"

static Byte iv[] = {1,2,3,4,5,6,7,8};
//static Byte iv[] = {12, 22, 32, 43, 51, 64, 57, 98};
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

 @implementation DeviceUtility


+ (NSInteger)OSVersion
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}



//加密
+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key

{
    NSString *ciphertext = nil;
    
    const char *textBytes = [plainText UTF8String];
    
    NSUInteger dataLength = [plainText lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char buffer[1024];
    
    memset(buffer, 0, sizeof(char));
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,kCCOptionPKCS7Padding,[key UTF8String], kCCKeySizeDES,iv,                                           textBytes, dataLength,buffer, 1024,&numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
//            ciphertext = [data base64Encoding];
        //NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
//        NSStringEncoding enc = NSUTF8StringEncoding;
        //ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:enc];
        ciphertext = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    return ciphertext;
}
//解密
+ (NSDictionary *) decryptUseDES:(NSString*)cipherText key:(NSString*)key
{
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[[cipherData length]];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          [cipherData length],
                                          &numBytesDecrypted);
    NSString* jsonString = nil;
    NSDictionary *dic = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
//        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
//        jsonString =[[NSString alloc] initWithData:data encoding:enc];
//        
//        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
    }
    return dic;
}

+ (NSString *)getParameterStringWithdic:(NSDictionary *)dic{
    NSMutableArray * dataArray = [NSMutableArray array];
    for (NSString * temp in [dic allKeys]) {
        NSString * value = [dic objectForKey:temp];
        NSString * string =  [NSString stringWithFormat:@"%@=%@",temp,value];
        [dataArray addObject:string];
    }
    NSString * result_str = [dataArray componentsJoinedByString:@"&"];

    return result_str;
}

//获取当前app版本号
+ (NSString *)getCurrentAppVerison{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}


+(NSString *) encryptDES:(NSString *)plainText key:(NSString *)key {
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES, iv,textBytes, dataLength,buffer, 1024,&numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return  ciphertext;
}




@end
