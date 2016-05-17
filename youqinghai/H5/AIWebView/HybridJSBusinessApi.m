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
#import "KMMessagView.h"
#import "TravelsViewModel.h"
#import <objc/runtime.h>
#import "AITabBarController.h"

static NSString * key_UIComment = @"key_UIComment";
static NSString * key_TravelModel = @"key_TravelModel";

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

- (void) jumpToTravelComment:(NSString *)travelId {

    [self sendComment:travelId];
 
}


- (void)sendComment:(NSString *)travelId{
    KMMessagView *messagebox = objc_getAssociatedObject(self, (__bridge const void *)(key_UIComment));
    if (!messagebox) {
        CGSize size=[UIScreen mainScreen].bounds.size;
        CGRect boxFrame=CGRectMake(0,size.height, size.width, 45);
        messagebox=[[KMMessagView alloc]initWithFrame:boxFrame PlaceText:@"评论" PlaceColor:[UIColor lightGrayColor]];
        messagebox.isHiddenBar = self.isHiddenBar;
        __weak UIViewController *weakSelf = self;
        [messagebox sendMessage:^(NSString *txt) {
            NSLog(@"%@",txt);
            [[weakSelf.travelsViewModel commentTravelsWithTravelId:[travelId integerValue] withComContent:txt] subscribeNext:^(id x) {
                
            } error:^(NSError *error) {
                
            }];
        }];
        [self.view addSubview:messagebox];
    }
    [messagebox.Inputview becomeFirstResponder];
   
}

- (TravelsViewModel *)travelsViewModel {
    TravelsViewModel *viewModel = objc_getAssociatedObject(self, (__bridge const void *)(key_TravelModel));
    if (!viewModel) {
         viewModel = [[TravelsViewModel alloc] init];
        objc_setAssociatedObject(self, (__bridge const void *)(key_TravelModel),viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return viewModel;
}

- (BOOL)isHiddenBar{

    UINavigationController* nav =  [AITabBarController sharedTabbar].selectedViewController;
    NSArray *array = nav.viewControllers ;
    if (array.count > 1) {
        return YES;
    }
    return NO;
}

 @end
