//
//  NavigationViewController.m
//  RWXChina
//
//  Created by 冉晨阳 on 15/3/24.
//  Copyright (c) 2015年 rcy. All rights reserved.
//

#import "AINavigationController.h"

@interface AINavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property(nonatomic,weak) UIViewController* currentShowVC;

@end

@implementation AINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configBackgroundImage];
    [self configTitleTextStyle];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
  AINavigationController * nav = [super initWithRootViewController:rootViewController];
  //如果开启左滑返回手势   需要打开注释代码
//  self.interactivePopGestureRecognizer.delegate = self;
//  nav.delegate = self;
  return nav;
}

#pragma mark - UINavigationContorllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  if (navigationController.viewControllers.count == 1) {
    self.currentShowVC = nil;
  }else
    self.currentShowVC = viewController;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
  if (gestureRecognizer == self.interactivePopGestureRecognizer) {
    return (self.currentShowVC == self.topViewController);
  }
  return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  设置NavgationBar的背景图片，红色背景
 */
-(void)configBackgroundImage{
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics: )]) {
        //        NSString *imageName = @"nav";
        //        UIImage *image = [UIImage imageNamed:imageName];
        //        UIImage *strechImg = [image stretchableImageWithLeftCapWidth:0 topCapHeight:10];
        //        [self.navigationBar setBackgroundImage:strechImg forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.barTintColor = navigatorColor();
        self.navigationBar.shadowImage = [UIImage new];

    }
    
}

/**
 *  设置导航上的title显示样式，白色文
 字
 */
-(void)configTitleTextStyle{
    //    NSShadow *shadow = [[NSShadow alloc] init];
    //    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    //    shadow.shadowOffset = CGSizeMake(0, 0);
    UIColor *textColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textColor, NSForegroundColorAttributeName,
                                                //                                                shadow, NSShadowAttributeName,
                                                [UIFont systemFontOfSize:20],
                                                NSFontAttributeName,
                                                nil]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}
/**
 *  push隐藏tab
 *
 *  @param viewController <#viewController description#>
 *  @param animated       <#animated description#>
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
