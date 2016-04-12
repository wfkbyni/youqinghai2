//
//  HybridViewController.m
//  HybridDemo
//
//  Created by mouxiaochun on 15/8/21.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import "HybridViewController.h"
@implementation HybridViewController
- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

}
- (void)dealloc
{
  [self.view clearWebView];
}

-(instancetype)init{
  
  self = [super init];
  if (self) {
    //        self.hidesBottomBarWhenPushed = YES;

  }
  return self;
}
-(void)loadView{
  
  [super loadView];
  self.view.backgroundColor = [UIColor whiteColor];
  // [self.view loadWebView];//加载webview
  self.navigationItem.leftBarButtonItem = self.leftBackItem;

}


-(void)viewDidLoad{
  
  [super viewDidLoad];

  //建立桥接
   
  [self addLeftBarItem];
  
  [self configBlock];
  
}

- (void) addLeftBarItem
{
  SEL sel = NSSelectorFromString(@"leftBarItem");
  if ([self respondsToSelector:sel]) {
    [self performSelectorOnMainThread:sel withObject:nil waitUntilDone:NO];
  }

}


- (void) configBlock
{
   
}
-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
   
}


#pragma mark -- getter && setter

-(UIWebView *)webView{
  
  return self.view.webView;
}



- (UIBarButtonItem *) leftBackItem {
  
  UIImage *back = [UIImage imageNamed:@"back"];
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:back style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
  return item;
}

- (void) pop {
  
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - needRefresh
- (void)loadPageContent
{
  [self.view.webView loadURLRequest];
}

- (void)refresh
{
   [self.view.webView loadURLRequest];
}
@end
