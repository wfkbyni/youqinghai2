//
//  AIWebViewLoadRequest.m
//  HybridDemo
//
//  Created by mouxiaochun on 15/8/21.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import "AIWebViewLoadRequest.h"
#import "HybridHeader.h"

#define WeakPointer(weakSelf) __weak __typeof(&*self)weakSelf = self

@implementation UIWebView (LoadURL)


- (void)loadRequestWithURL:(id)url{
  if ([url isKindOfClass:[NSURL class]]) {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];
  }else if ([url isKindOfClass:[NSString class]]){
      
      NSURL *URL = nil;
      if (self.webviewLoadType == HybridWebViewLoadType_Local) {
          URL = [[NSBundle mainBundle] URLForResource:url withExtension:nil];
      }else
          URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self loadRequest:request];
    
  }else {
    NSLog(@"您传入的不是url:%@",url);
  }
  
}


- (void)loadURLRequest{
  
  /**
   *   preparedForLoad  一定放在webView加载之前
   */
  [self preparedForLoad];
  
  if (self.webviewLoadType == HybridWebViewLoadType_Templet) {
    //单页面加载时，检测模板资源是否存在
    [self preloadTemples];

//    [self openHomeWithRelativePathFile:self.fileURL];
  }else
    [self loadRequestWithURL:self.fileURL];
}


/**
 *  预加载模板
 */
-(void)preloadTemples{
  
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
//     [iPUDownloadResource downloadResource:^(float progress) {
//        if (progress == 1.0) {
//         //加载数据
//        [self openHomeWithRelativePathFile:self.fileURL];
//      }
//    }];
    
  });
}



@end
