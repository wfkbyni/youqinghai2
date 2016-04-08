//
//  GTMBase64+Des.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "GTMBase64+Des.h"
#import "GTMBase64.h"

#define YQH_DEBUGMODEL @"eVfcMiA="          // 测试环境密钥
#define YQH_RELEASEMODEL @"swimQingHaiAPP=	" // 发布环境密钥

static NSString *const DESEncrypt_Key     = YQH_DEBUGMODEL;

@implementation GTMBase64 (DES)

#pragma mark - AES

+ (NSString *)desEncrypt:(NSString *)plainText
{
    return [[self class] encryptUseDES:plainText
                                   key:DESEncrypt_Key];
}

+ (NSString *)desDecrypt:(NSString *)encryptText
{
    return [[self class] des:encryptText
                      desKey:DESEncrypt_Key
                   operation:kCCDecrypt];
}

/**
 *  @brief 加密
 *
 *  @param plainText <#plainText description#>
 *  @param key       <#key description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key

{
    static Byte iv[] = {12, 22, 32, 43, 51, 64, 57, 98};
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
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        //        NSStringEncoding enc = NSUTF8StringEncoding;
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:enc];
        
    }
    return ciphertext;
}

/**
 *  @brief 解密
 *
 *  @param text      <#text description#>
 *  @param desKey    <#desKey description#>
 *  @param operation <#operation description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)des:(NSString*)text
           desKey:(NSString *)desKey
        operation:(CCOperation)operation
{
    NSData* cipherData = [GTMBase64 decodeString:text];
    unsigned char buffer[[cipherData length]];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    Byte iv[] = {12, 22, 32, 43, 51, 64, 57, 98};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [desKey UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          [cipherData length],
                                          &numBytesDecrypted);
    NSString* jsonString = nil;
    if (cryptStatus == kCCSuccess) {
        jsonString = [[NSString alloc] initWithBytes:buffer length:(NSUInteger)numBytesDecrypted encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
