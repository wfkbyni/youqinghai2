//
//  AIWebViewBridge.m
//  AIWebView
//
//  Created by mouxiaochun on 15/8/21.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import "AIWebViewBridge.h"
#import "WebViewJavascriptBridge.h"
#import "AIWebView.h"
#import <objc/runtime.h>
#import "NSDictionary+Null.h"
#import "ObjcLookupMethod.h"
#import "AIHybridJSParam.h"

@protocol MessagesFromJSHandler <NSObject>

-(void)recieveMessageFromJS:(id)data completion:(WVJBResponseCallback)responseCallback;

@end


static NSString * key_WebViewJavascriptBridge = @"key_WebViewJavascriptBridge";
static NSString * kConnectToNative = @"kConnectToNative";//应该与JS文件中注册的名称统一
static NSString * kEventActionToJS = @"kEventActionToJS";
#pragma mark --  UIWebView Bridge


@implementation UIWebView (Bridge)


- (WebViewJavascriptBridge *)bridge{
    WebViewJavascriptBridge *_bridge = objc_getAssociatedObject(self, (__bridge const void *)(key_WebViewJavascriptBridge));
    return _bridge;
}

- (void)configBridge:(id<MessagesFromJSHandler,UIWebViewDelegate>)webviewDelegate{
    [WebViewJavascriptBridge enableLogging];
    WebViewJavascriptBridge *bridge = [WebViewJavascriptBridge bridgeForWebView:self webViewDelegate:webviewDelegate handler:nil resourceBundle:nil];
    
    objc_setAssociatedObject(self, (__bridge const void *)(key_WebViewJavascriptBridge), bridge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.bridge registerHandler:kConnectToNative handler:^(id data, WVJBResponseCallback responseCallback) {
        [webviewDelegate recieveMessageFromJS:data completion:responseCallback];
    }];
}

@end



@implementation UIView(FindNav)
-(UINavigationController *)navgationController{
    
    
    UIViewController *vc = [self viewController];
    
    return vc.navigationController;
}

- (UIViewController *)viewController
{
    id target=self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]])
            break;
    }
    return target;
}

@end


#pragma mark --  UIView Bridge


@implementation UIView (Bridge)

- (id)webviewDelegate { return self; }

- (void)loadBridge {
    
    [self.webView configBridge:self.webviewDelegate];
    
      
    
}



#pragma mark ---处理来自JS的消息
-(void)recieveMessageFromJS:(id)data completion:(WVJBResponseCallback)responseCallback {
    if([data isKindOfClass:[NSDictionary class]]){
        
         NSDictionary *dataDic = (NSDictionary*)data;
         NSString *key = [data valueForKeyOfNSString:@"key"];
         if (key.length == 0) return;//没有方法名
         id value = [dataDic objectForKey:@"value"];
         SEL selector = NSSelectorFromString(key);
        if ([self respondsToSelector:selector]) {
            Method method = class_getInstanceMethod([self class], selector);
            id result =   [ObjcLookupMethod invokeMethod:method
                                                selector:selector
                                                   class:[self class]
                                                  target:self
                                                  params:value,nil];
            if (![result isKindOfClass:[NSNull class]]) {
                responseCallback(result);//回调数据给JS端
            }
        }else if ([self.viewController respondsToSelector:selector]){
            id target = self.viewController;
            Method method = class_getInstanceMethod([target class], selector);
            id result =   [ObjcLookupMethod invokeMethod:method
                                                selector:selector
                                                   class:[target class]
                                                  target:target
                                                  params:value,nil];
            if (![result isKindOfClass:[NSNull class]]) {
                if (result == nil) {
                    responseCallback(@"");
                }else
                    responseCallback(result);//回调数据给JS端
            }

        }else{
            id result = [ObjcLookupMethod lookupMethodFromClassList:key
                                                             params:value,responseCallback,nil];
            if (![result isKindOfClass:[NSNull class]]) {
                responseCallback(result);
            }
        }
    }
}

#pragma mark --- OC --->  JS

/**
 *  按钮点击事件
 *
 *  @param data
 */
-(void)ocToJs_eventAction:(id)data{
    [self ocToJs_callHandler:kEventActionToJS data:data];
}

-(void)ocToJs_callHandler:(NSString*)handlerName data:(id)data{
    
    [self.webView.bridge callHandler:handlerName data:data];
}

/**
 * 系统弹窗按钮事件
 *
 */
- (void)ocToJs_alertEventAction:(id)data {

    
}
@end
