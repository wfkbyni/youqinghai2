//
//  AIUmengCheckUpdate.m
//  AskGanghood_20160106
//
//  Created by 冉晨阳 on 16/2/26.
//  Copyright © 2016年 mmc. All rights reserved.
//

#import "AIUmengCheckUpdate.h"

@implementation AIUmengCheckUpdate

+ (void)checkUpdateWithAppkey:(NSString *)appkey channel:(NSString *)channel
{
    [UMCheckUpdate checkUpdateWithAppkey:appkey channel:channel];
}

+ (void)checkUpdate:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherTitle appkey:(NSString *)appkey channel:(NSString *)channel
{
    [UMCheckUpdate checkUpdate:title cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle appkey:appkey channel:channel];
}
@end
