//
//  HybridJSApi.m
//  HybridDemo
//
//  Created by mouxiaochun on 15/8/21.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import "HybridJSApi.h"
#import "HybridViewController.h"
 
@implementation UIViewController (HybridJSApi)

//打开新的VC
- (void) openPage:(JSDictionary *)jsParam{
  //1.未打开过新页面
  //2.传递的参数有效
  if (NO == self.isNestedPush && [jsParam isKindOfClass:[JSDictionary class]]) {
    self.isNestedPush = YES;
     JSMDictionary *jsonParam  =  [jsParam objectForKey:key_JSParam];
    HybridViewController *viewController = [[HybridViewController alloc] init];
    viewController.view.webView.fileURL   = [jsParam valueForKeyOfNSString:key_PagePath];
    viewController.view.webView.isEncrypt = [jsParam valueForKeyOfBOOL:key_Encrypt];
    viewController.view.webView.jsonParam = jsonParam;
    viewController.view.webView.isInter   = [jsParam valueForKeyOfNSString:key_IsInter];

    if ([jsonParam.allKeys containsObject:key_IsScales]) {
      viewController.view.webView.isScales  = [[jsonParam objectForKey:key_IsScales] boolValue];
//      viewController.view.webView.isScales = YES;
    }
    
    viewController.navigationItem.title = [jsParam valueForKeyOfNSString:key_Title];
    [viewController.view.webView loadURLRequest];
    [self.navigationController pushViewController:viewController animated:YES];
  }
}


 


//打开原生VC
- (void) openNativePage:(JSDictionary *)jsParam{
  
  NSString *className = jsParam[@"className"];
  if ([className isKindOfClass:[NSString class]]) {
    
    UIViewController *viewController =  [[NSClassFromString(className) alloc] init];
    viewController.jsonParamForNative = [jsParam objectForKey:key_JSParam];
    viewController.navigationItem.title = [jsParam valueForKeyOfNSString:key_Title];
    [self.navigationController pushViewController:viewController animated:YES];
  }
}


/**
 *  返回按钮事件
 */
- (void) backButtonAction {
  [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  回到顶层
 */
- (void) backToRoot {
  [self.navigationController popToRootViewControllerAnimated:YES];
}
/**
 *  pop view controller
 *
 *  @param param
 */
- (void) popByCount: (id)param {
  if(!(param&&[param isKindOfClass:[NSDictionary class]])) return;
  
  NSInteger count = [[param objectForKey:@"count"] integerValue];//默认0
   BOOL needReload = [[param objectForKey:@"needReload"] boolValue];//默认NO
  
  NSArray *viewControllers = self.navigationController.viewControllers;
  NSInteger viewsCount = viewControllers.count;
  if (viewsCount > count) {
    if (count==-1) {
      //回到首页
      [self backToRoot];
    }else if (count < 1){
      //当传入的数目为 0 或 1 时，则直接返回到上一级
      [self backButtonAction];
    }else{
      //需要回退count个,取出栈内第index个viewController
      NSInteger index = viewControllers.count - count;
      UIViewController *viewController = viewControllers[index-1];
      [self.navigationController popToViewController:viewController animated:YES];
      if(needReload){
        SEL selector = NSSelectorFromString(@"loadPageContent");
        if ([viewController respondsToSelector:selector]) {
          [viewController performSelector:selector withObject:nil afterDelay:0];
        }
      }
    }
  }
}




 
#pragma mark ---

- (void)barButtonItemClicked:(NSNumber *)direction {
  
  if ([direction intValue] == 0) {
    
    if ([[NSThread currentThread] isMainThread]) {
      [self excuteBackEvent];
    } else {
      dispatch_sync(dispatch_get_main_queue(), ^{
        [self excuteBackEvent];
      });
    }
  }else {
    
    SEL selector = NSSelectorFromString(@"ocToJs_eventAction:");
    if ([self.view respondsToSelector:selector]) {
      NSString *eventType = @"bar"; //bar->导航栏上的按钮, alert->系统弹窗按钮
      NSString *leftOrRight = @"right";
      NSString *value = @"右侧";
      NSString *msg = [NSString stringWithFormat:@"您点击了原生按钮:%@",value];
      [self.view performSelector:selector withObject:@{@"key":leftOrRight,@"value":msg,@"eventType":eventType} afterDelay:0];
    }
    
  }
  
}


- (void)excuteBackEvent {
  [self.view.webView stringByEvaluatingJavaScriptFromString:@"function checkObj() { "
   "if(typeof(clickObj) != 'undefined')\
   {clickObj.leftButtonClick();"
   "return 1;}\
   else {"
   "return 0;"
   "}"
   "};"
   "document.getElementsByTagName('head')[0].appendChild(script);"];
  BOOL result =    [[self.view.webView stringByEvaluatingJavaScriptFromString:@"checkObj()"] boolValue];
  if (!result) {
    [self backButtonAction];
  }
  
}



#pragma mark --- show alert
- (void) showAlertView:(NSDictionary *)jsonParam {
  NSString *tips = jsonParam[@"message"];
  if (![tips isKindOfClass:[NSString class]] || tips.length == 0)
    return ;
  
  dispatch_async(dispatch_get_main_queue(),^{
    NSString *left = [NSString stringWithFormat:@"%@",jsonParam[@"leftButtonTitle"]];
    NSString *right = nil;
    if ([jsonParam objectForKey:@"rightButtonTitle"]) {
      right = [jsonParam objectForKey:@"rightButtonTitle"];
    }
    NSInteger index = 0;
    if ([jsonParam objectForKey:@"index"]) {
      index = [[jsonParam objectForKey:@"index"] integerValue];
    }
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:tips
                                                   delegate:self
                                          cancelButtonTitle:left
                                          otherButtonTitles:right,nil];
    alert.tag = index;
    [alert show];
  });
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if ([[NSThread currentThread] isMainThread]) {
    [self excuteAlertEvent:buttonIndex index:alertView.tag];
  } else {
    dispatch_sync(dispatch_get_main_queue(), ^{
      [self excuteAlertEvent:buttonIndex index:alertView.tag];
    });
  }
  
}

- (void)excuteAlertEvent:(NSInteger)direction index:(NSInteger)index{
  
  
  SEL selector = NSSelectorFromString(@"ocToJs_eventAction:");
  if ([self.view respondsToSelector:selector]) {
    NSString *eventType = @"alert"; //bar->导航栏上的按钮, alert->系统弹窗按钮
    NSString *leftOrRight = direction == 0?@"left":@"right";
    NSString *value = direction == 0?@"左侧":@"右侧";
    NSString *msg = [NSString stringWithFormat:@"您点击了系统弹窗按钮:%@",value];
    NSString *indexOfStr = [NSString stringWithFormat:@"%zi",index];
    [self.view performSelector:selector withObject:@{@"key":leftOrRight,@"value":msg,@"eventType":eventType,@"index":indexOfStr} afterDelay:0];
  }
  
}

@end
