//
//  AIWebViewBridge.h
//  AIWebView
//
//  Created by mouxiaochun on 15/8/21.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIView (Bridge)

- (void)loadBridge;

/**
 *  按钮点击事件
 *
 *  @param data
 */
- (void)ocToJs_eventAction:(id)data;

/**
 * 系统弹窗按钮事件
 *
 */
- (void)ocToJs_alertEventAction:(id)data;


@end


