//
//  AINavigationBar.h
//  AINavigationBar
//
//  Created by mouxiaochun on 15/8/20.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, TopBarItemDirection) {
    
    TopBarItemDirectionLeft  = 0,
    TopBarItemDirectionRight = 1

};


static NSString* kBarItemItemClicked = @"kBarItemItemClicked";

@interface UIViewController (navigation)

/**
 *  设置页面标题
 *
 *  @param title 标题
 */
- (void)setPageTitle:(NSString *)title;

/**
 *  设置左侧返回按钮
 */
- (void)setBackBarItem;

- (void)setTextBarItem:(NSDictionary *)jsParam ;
- (void)setImageBarItem:(NSDictionary *)jsParam ;

//重置导航栏
- (void) resetNavigationBar;
//导航栏透明
- (void) transparentNavigationBar;


/**
 *  设置导航栏的文本按钮，如果要想接收点击事件，需实现“- (void)barButtonItemClicked:(NSNumber *)direction”
 *
 *  @param barItemTitle 按钮文本
 *  @param direction    左/右侧
 */
- (void)setTextBarItem:(NSString *)barItemTitle direction:(TopBarItemDirection)direction;

/**
 *  设置导航栏的图片按钮,如果要想接收点击事件，需实现“- (void)barButtonItemClicked:(NSNumber *)direction”
 *
 *  @param barItemImage 图片名称
 *  @param direction    左/右侧
 */
- (void)setImageBarItem:(NSString *)barItemImage direction:(TopBarItemDirection)direction;

- (UIButton *)buttonCreator:(TopBarItemDirection)direction;

/**
 *  点击左按钮,如果要想接收点击事件，需要实现方法"- (void)ocToJs_eventAction:(NSDictionary *)info"
 */
- (void)leftBarItemEvent;

/**
 *  点击右按钮,如果要想接收点击事件，需要实现方法"- (void)ocToJs_eventAction:(NSDictionary *)info"
 */
- (void)rightBarItemEvent;


@end
