//
//  AIUmeng.h
//  AIUmeng
//
//  Created by 冉晨阳 on 16/2/26.
//  Copyright © 2016年 rancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIHeaderFile.h"
//Umeng 统计
@interface AIUmengStatistics : NSObject

/** 初始化友盟统计模块
 @param appKey 友盟appKey.
 @return void
 */
+ (void)startWithAppkey;

/** 初始化友盟统计模块
 @param appKey 友盟appKey.
 @param reportPolicy 发送策略, 默认值为：BATCH，即“启动发送”模式
 @param channelId 渠道名称,为nil或@""时, 默认为@"App Store"渠道
 @return void
 */

+ (void) startWithAppKey:(NSString *)appKey
            reportPolicy:(ReportPolicy )rp
               channelId:(NSString *)chnnelId;

/** 设置是否打印sdk的log信息, 默认NO(不打印log).
 @param value 设置为YES,umeng SDK 会输出log信息可供调试参考. 除非特殊需要，否则发布产品时需改回NO.
 @return void.
 */
+ (void)setLogEnabled:(BOOL)value;

@end
