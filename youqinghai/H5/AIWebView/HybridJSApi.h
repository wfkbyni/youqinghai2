//
//  HybridJSApi.h
//  HybridDemo
//
//  Created by mouxiaochun on 15/8/21.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HybridHeader.h"



@interface UIViewController (HybridJSApi)


//打开新的VC,网页
- (void) openPage:(JSDictionary *)jsParam;

//打开原生VC
- (void) openNativePage:(JSDictionary *)jsParam;

/**
 *  返回按钮事件
 */
- (void) backButtonAction ;

/**
 *  回到顶层
 */
- (void) backToRoot;

/**
 *  pop view controller
 *
 *  @param param
 */
- (void) popByCount: (id)param  ;
/**
 * 获取用户是否登录
 */
- (BOOL) isLogin;
/**
 * 进入登录页面
 */
- (void) toLoginView;

#pragma mark -- 缓存

- (void) cacheObject:(NSDictionary *)jsonParam;

- (void) objectForCacheKey:(NSString *)key;

#pragma mark -- sessionID

- (NSDictionary *) getSessionID ;
- (void) saveSessionID:(NSString *)sessionID ;

#pragma mark -- 消息提示

- (void) messageOfToastStyle:(NSString *)message ;
- (void) showSysAlert:(NSDictionary *)jsonParam;
- (void) showCustomAlert:(NSDictionary *)jsonParam;

@end

