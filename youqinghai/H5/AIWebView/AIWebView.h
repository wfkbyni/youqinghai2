//
//  AIWebView.h
//  AIWebView
//
//  Created by mouxiaochun on 15/8/20.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




@interface UIView (WebView) <UIWebViewDelegate>

- (UIWebView *)loadWebView;
- (UIWebView *)webView;
- (void)clearWebView;
- (void) scalesPageToFit:(BOOL)fit;
@property(copy, nonatomic) void(^loadWebViewStartBlock)(void);
@property(copy, nonatomic) void(^loadWebViewFinishedBlock)(void);
@property(copy, nonatomic) void(^loadWebViewErrorBlock)(void);
@end
