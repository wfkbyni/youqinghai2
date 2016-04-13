//
//  AIUmeng.m
//  AIUmeng
//
//  Created by 冉晨阳 on 16/2/26.
//  Copyright © 2016年 rancy. All rights reserved.
//

#import "AIUmengStatistics.h"

@implementation AIUmengStatistics



+ (void)startWithAppkey
{
    [MobClick startWithAppkey:UMENG_APP_KEY];
}

+ (void) startWithAppKey:(NSString *)appKey reportPolicy:(ReportPolicy )rp channelId:(NSString *)chnnelId
{
    [MobClick startWithAppkey:appKey reportPolicy:rp   channelId:chnnelId];
}

+ (void)setLogEnabled:(BOOL)value
{
    [MobClick setLogEnabled:value];
}
@end
