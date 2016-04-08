//
//  DeviceUtility.h
//  RenRen
//
//  Created by Zeng Hao on 15/1/18.
//  Copyright (c) 2015年 Zeng Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceUtility : NSObject

//加密
+ (NSString *) encryptUseDES:(NSString *)plainText;
//解密
+ (NSDictionary *) decryptUseDES:(NSString*)cipherText;

//加密接口参数拼接
+ (NSString *)getParameterStringWithdic:(NSDictionary *)dic;


//加密
+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
//解密
+ (NSDictionary *) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
@end
