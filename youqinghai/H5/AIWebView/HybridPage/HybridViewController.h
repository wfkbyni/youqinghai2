//
//  HybridViewController.h
//  HybridDemo
//
//  Created by mouxiaochun on 15/8/21.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AIWebViewLoadRequest.h"
#import "AIWebView.h"
typedef NS_ENUM(NSUInteger, JFWebViewLoadType) {
  JFWebViewLoadType_DocumentsSource = 0,//documents下面文件加载
  JFWebViewLoadType_BundleSource = 1,	  //bundle下面文件加载
  JFWebViewLoadType_Url = 2			  //url加载
};

@interface HybridViewController : UIViewController

@property (nonatomic,assign)JFWebViewLoadType loadType;

@property (nonatomic, strong) NSString *fileName;

-(UIWebView *)webView;
@end
