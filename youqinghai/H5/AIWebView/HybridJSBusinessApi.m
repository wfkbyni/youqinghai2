//
//  YQHBusinessApi.m
//  youqinghai
//
//  Created by mouxiaochun on 16/5/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "HybridJSBusinessApi.h"
#import "UMSocialData.h"
#import "ZUserModel.h"
@implementation UIViewController (YQHBusinessApi)

/**
 ** 游记分享
 **/
- (void)jumpToNativeTravelShare:(NSDictionary *)params  {

    NSString *title = params[@"title"];
    NSString *introduce = params[@"introduce"];
    NSString *Id = params[@"Id"];
    NSString *imageURL = params[@"imageURL"];
    NSString *url = [NSString stringWithFormat:@"http://www.sinata.cn:9402/swimQinghai/share?code=1&Id=%zi", Id];
    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:imageURL] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        [UMSocialData defaultData].extConfig.qqData.title =  title;
        [UMSocialData defaultData].extConfig.wechatSessionData.title= title;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title= title;
//        NSString *url = [NSString stringWithFormat:@"http://www.sinata.cn:9402/swimQinghai/share?code=0&Id=%zi", Id];
        [UMSocialWechatHandler setWXAppId:@"wxeb076ac34fb771b7" appSecret:@"6dc56b5630579fa7d4b614edabfa3434" url:url];
        [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1799384586" secret:@"dc96ffc3a2ca7eeb3f8e8c63d8493d9f" RedirectURL:url];
        [UMSocialQQHandler setQQWithAppId:@"1105195687" appKey:@"1Mj6wJJiiYtLZJaJ" url:url];
        
        [UMSocialSnsService presentSnsIconSheetView:self appKey:@"570b744e67e58e12e2000466"shareText: introduce shareImage:image shareToSnsNames:@[UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone,UMShareToSina] delegate:nil];
    }];
}

/**
 ** 获取当前APP登陆用户的ID，如果木有登陆不需要跳转到登陆页面，还回值为空
 **/
- (NSString *)getUserIdNotNeedLogin{

    NSString *userID = [ZUserModel shareUserModel].userId;
    if (userID.length > 0) {
        return userID;
    }
    return nil;
}

/**
 ** 获取当前APP登陆用户的ID，如果木有登陆需要跳转到登陆页面，还回值为空
 **/
- (NSString *)getUserIdNeedLogin {

    NSString *userId =  [ZUserModel getUserIdNeedLogin:self];
    return userId;
}

@end
