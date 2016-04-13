//
//  AIUmengCheckUpdate.h
//  AskGanghood_20160106
//
//  Created by 冉晨阳 on 16/2/26.
//  Copyright © 2016年 mmc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMCheckUpdate.h"

@interface AIUmengCheckUpdate : NSObject

/** 按渠道检测更新
 检查当前app是否有更新，有则弹出UIAlertView提示用户,当用户点击升级按钮时app会跳转到您预先设置的网址。
 无更新不做任何操作。
 需要先在服务器端设置app版本信息，默认渠道是App Store.
 @param appkey 友盟统计 appkey.
 @param channel 渠道名称,当值为 nil 渠道是App Store.
 @return void.
 */
+ (void)checkUpdateWithAppkey:(NSString *)appkey channel:(NSString *)channel;

/** 按渠道检测更新
 检查当前app是否有更新，有则弹出UIAlertView提示用户,当用户点击升级按钮时app会跳转到您预先设置的网址。
 无更新不做任何操作。
 需要先在服务器端设置app版本信息，默认渠道是App Store.
 
 @param title 对应UIAlertView的title.
 @param cancelTitle 对应UIAlertView的cancelTitle.
 @param otherTitle 对应UIAlertView的otherTitle.
 @param appkey 友盟统计 appkey.
 @param channel 渠道名称,当值为 nil 渠道是App Store.
 @return void.
 */
+ (void)checkUpdate:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherTitle appkey:(NSString *)appkey channel:(NSString *)channel;
@end
