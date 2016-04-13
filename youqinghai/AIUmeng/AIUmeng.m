//
//  AIUmeng.m
//  AskGanghood_20160106
//
//  Created by 冉晨阳 on 16/2/26.
//  Copyright © 2016年 mmc. All rights reserved.
//

#import "AIUmeng.h"

@implementation AIUmeng


+ (void)setLogEnabled:(BOOL)value
{
    [MobClick setLogEnabled:value];
    [UMCheckUpdate setLogEnabled:value];
    [UMSocialData openLog:value];
    [UMessage setLogEnabled:value];
}

///---------------------------------------
///umeng Statistics
///---------------------------------------

+ (void)startStatisticsWithAppkey
{
    [AIUmengStatistics startWithAppkey];
}

+ (void)startStatisticsWithAppKey:(NSString *)appKey reportPolicy:(ReportPolicy)rp channelId:(NSString *)chnnelId
{
    [AIUmengStatistics startWithAppKey:appKey reportPolicy:rp channelId:chnnelId];
}

///---------------------------------------
///umeng update
///---------------------------------------

+ (void)checkUpdateWithAppkey:(NSString *)appkey channel:(NSString *)channel
{
    [AIUmengCheckUpdate checkUpdateWithAppkey:appkey channel:channel];
}

+ (void)checkUpdate:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherTitle appkey:(NSString *)appkey channel:(NSString *)channel
{
    [AIUmengCheckUpdate checkUpdate:title cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle appkey:appkey channel:channel];
}


///---------------------------------------
///umeng share
///---------------------------------------

+ (void) setSocialApp_key
{
    [UMSocialData setAppKey:UMENG_APP_KEY];
    
}


+ (void)presentSnsController:(UIViewController *)controller
                      appKey:(NSString *)appKey
                   shareText:(NSString *)shareText
                  shareImage:(id)shareImage
             shareToSnsNames:(NSArray *)snsNames
                    delegate:(id<UMSocialUIDelegate>)delegate
                  socialType:(SocialViewType)socialType
{
    if (socialType == SocialViewType_TableViewController) {
        [UMSocialSnsService presentSnsController:controller appKey:appKey shareText:shareText shareImage:shareImage shareToSnsNames:snsNames delegate:delegate];
    }else if (socialType == SocialViewType_ActionSheet) {
        [UMSocialSnsService presentSnsIconSheetView:controller appKey:appKey shareText:shareText shareImage:shareImage shareToSnsNames:snsNames delegate:delegate];
    }
}


///---------------------------------------
/// @name 反馈
///---------------------------------------

+ (void) setFeedbackAppkey:(NSString *)appkey
{
    [UMFeedback setAppkey:appkey];
}

+ (void)showFeedbackWithViewController:(UIViewController *)viewControllver isModal:(BOOL)isModal
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    //如果是模态推送
    if (isModal) {
        [viewControllver presentViewController:[UMFeedback feedbackModalViewController] animated:YES completion:nil];
    }else{
        [viewControllver.navigationController pushViewController:[UMFeedback feedbackViewController] animated:YES];
    }
}


///---------------------------------------
/// @name 推送
///---------------------------------------

+ (void) unregisterForRemoteNOtifications
{
    [UMessage unregisterForRemoteNotifications];
}

+ (NSString *)getDeviceToken:(NSData *)deviceToken
{
    return [[[[deviceToken description]
              stringByReplacingOccurrencesOfString: @"<" withString: @""]
             
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            
            stringByReplacingOccurrencesOfString: @" " withString: @""];

}
@end
