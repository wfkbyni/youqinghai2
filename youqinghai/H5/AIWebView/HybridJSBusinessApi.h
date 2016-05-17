//
//  YQHBusinessApi.h
//  youqinghai
//
//  Created by mouxiaochun on 16/5/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UIViewController (YQHBusinessApi)
/**
 ** 游记分享
 **/
- (void)jumpToNativeTravelShare:(NSDictionary *)params ;

/**
 ** 获取当前APP登陆用户的ID，如果木有登陆需要跳转到登陆页面，还回值为空
 **/
- (NSString *)getUserIdNeedLogin;
/**
 ** 获取当前APP登陆用户的ID，如果木有登陆不需要跳转到登陆页面，还回值为空
 **/
- (NSString *)getUserIdNotNeedLogin;
/**
 ** 拉起评论输入框
 **/
- (void) jumpToTravelComment:(NSString *)travelId;
/**
 ** 跳转到个人详情页
 **/
- (void) jumpToPersonDetail:(NSString *)userId;
/**
 ** 跳转到游记详情页
 **/
- (void) jumpToTravelDetail:(NSString *)travelsId;
@end
