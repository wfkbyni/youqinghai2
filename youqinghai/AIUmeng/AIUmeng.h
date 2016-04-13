//
//  AIUmeng.h
//  AskGanghood_20160106
//
//  Created by 冉晨阳 on 16/2/26.
//  Copyright © 2016年 mmc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIHeaderFile.h"
#import "MobClick.h"
#import "UMSocial.h"
#import "UMFeedback.h"
#import "UMessage.h"

//分享样式
typedef NS_ENUM(NSInteger) {
    SocialViewType_TableViewController = 0,  //分享样式以列表样式展示
    SocialViewType_ActionSheet,             //分享样式以actionSheet样式展示
}SocialViewType;

@interface AIUmeng : NSObject

/*
 * 打开或者关闭所有的打印信息
 */
+ (void)setLogEnabled:(BOOL)value;

///---------------------------------------
///umeng Statistics
///---------------------------------------

/** 初始化友盟统计模块
 @param appKey 友盟appKey.
 @return void
 */
+ (void)startStatisticsWithAppkey;

/** 初始化友盟统计模块
 @param appKey 友盟appKey.
 @param reportPolicy 发送策略, 默认值为：BATCH，即“启动发送”模式
 @param channelId 渠道名称,为nil或@""时, 默认为@"App Store"渠道
 @return void
 */

+ (void)startStatisticsWithAppKey:(NSString *)appKey
                     reportPolicy:(ReportPolicy)rp
                        channelId:(NSString *)chnnelId;


///---------------------------------------
///umeng update
///---------------------------------------

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

///---------------------------------------
///umeng share
///---------------------------------------


/*
 * 设置app_key
 */
+ (void) setSocialApp_key;



///---------------------------------------
/// @name 快速分享
///---------------------------------------

/**
 弹出一个分享列表的UITableViewController
 
 @param controller 在该controller弹出分享列表的UIActionSheet
 @param appKey 友盟appKey
 @param shareText  分享编辑页面的内嵌文字
 @param shareImage 可以传入`UIImage`，或者`NSData`类型，分享内嵌图片,用户可以在编辑页面删除
 @param snsNames 你要分享到的sns平台类型，该NSArray值是`UMSocialSnsPlatformManager.h`定义的平台名的字符串常量，有UMShareToSina，UMShareToTencent，UMShareToRenren，UMShareToDouban，UMShareToQzone，UMShareToEmail，UMShareToSms等
 @param delegate 实现分享完成后的回调对象，如果不关注分享完成的状态，可以设为nil
 @param scoialType 分享的图标展示方式
 */
+(void) presentSnsController:(UIViewController *)controller
                      appKey:(NSString *)appKey
                   shareText:(NSString *)shareText
                  shareImage:(id)shareImage
             shareToSnsNames:(NSArray *)snsNames
                    delegate:(id <UMSocialUIDelegate>)delegate
                  socialType:(SocialViewType)socialType;


///---------------------------------------
/// @name 反馈
///---------------------------------------

+ (void) setFeedbackAppkey:(NSString *)appkey;

/**
 弹出一个反馈界面
 
 @param viewControllver 在该viewControllver弹出反馈界面
 @param isModal 是模态推送
 */
+ (void) showFeedbackWithViewController:(UIViewController *)viewControllver
                                isModal:(BOOL)isModal;

///---------------------------------------
/// @name 推送
///---------------------------------------


/**
 * 关闭推送功能
 */
+ (void) unregisterForRemoteNOtifications;

/**
 * 获取设备的token
 */
+ (NSString *) getDeviceToken:(NSData*)deviceToken;


@end
