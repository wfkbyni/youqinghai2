//
//  GTMBase64+Des.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "GTMBase64.h"

#import <CommonCrypto/CommonCryptor.h>

@interface GTMBase64 (DES)
/**
 *  @brief 加密
 *
 *  @param plainText <#plainText description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)desEncrypt:(NSString *)plainText;

/**
 *  @brief 解密
 *
 *  @param encryptText <#encryptText description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)desDecrypt:(NSString *)encryptText;

@end