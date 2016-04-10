//
//  RequestBaseAPI.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger,RequestAPIType) {
    RequestAPITypeGet,
    RequestAPITypePost,
};

@interface RequestBaseAPI : NSObject

+ (instancetype)standardAPI;

/**
 *  POST请求
 *
 *  @param apiString 使用接口文档规定的 API
 *  @param baseUrl   自定义基础路径(针对不同服务器)
 *  @param timeout   自定义此请求的超时时间
 *  @param params    请求参数
 */
- (RACSignal *)requestWithType:(RequestAPIType)type
                        params:(NSString *)params;

/**
 *  @brief 给请求参数加密
 *
 *  @param value 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
- (NSString *)getDesEncryptWithString:(NSString *)value;

#pragma mark - 上传附件
/**
 *  上传单个附件
 *
 *  @param apiString  使用接口文档规定的 API
 *  @param params     请求参数
 *  @param attachKey  附件名
 *  @param attachData 附件数据
 */
- (RACSignal *)postApiString:(NSString *)apiString
                      params:(NSDictionary *)params
                   attachKey:(NSString *)attachKey
                  attachData:(NSData *)attachData;

/**
 *  上传多个附件
 *
 *  @param apiString  使用接口文档规定的 API
 *  @param params     请求参数
 *  @param attaches   多个附件
 */
- (RACSignal *)postApiString:(NSString *)apiString
                      params:(NSDictionary *)params
               multiAttaches:(NSArray *)attaches;
/**
 *  专用于图片上传
 *
 *  @param apiString  API
 *  @param params     参数
 *  @param attachKey  图片参数
 *  @param attachData 图片数据
 *
 *  @return rac
 */
- (RACSignal *)ZpostApiString:(NSString *)apiString
                       params:(NSDictionary *)params
                    attachKey:(NSString *)attachKey
                   attachData:(NSArray *)attachData;
@end
