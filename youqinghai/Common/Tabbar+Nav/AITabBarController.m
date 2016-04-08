//
//  AITabBarController.m
//  SCData360
//
//  Created by mouxiaochun on 15/11/4.
//  Copyright © 2015年 mmc. All rights reserved.
//

#import "AITabBarController.h"
#import "AINavigationController.h"



@interface AITabBarController ()<UITabBarControllerDelegate>
{

  
}
@end

@implementation AITabBarController
- (void)viewWillAppear:(BOOL)animated
{
    
    
  [super viewWillAppear:animated];
  
}


- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

+ (AITabBarController *) sharedTabbar {
  
  
  static AITabBarController *tabbar = nil;
  
  static dispatch_once_t predicate;
  dispatch_once(&predicate, ^{
    tabbar = [[[self class] alloc] init];
    tabbar.delegate = tabbar;
 
    NSArray *classes = @[@"MainViewController",@"TravelsViewController",@"PersonalViewController"];
    //NSArray *titles  = @[@"首页",@"我的工作",@"最新状态"];
    //		192.168.3.106
    
    NSArray  *titles = @[@"首页",@"游记",@"我的"];
    NSArray *icons   = @[@"tab_form",@"tab_order",@"tab_personal"];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:4];
    for (int i  = 0; i< classes.count; i++) {
      NSString *className = classes[i];
      Class class = NSClassFromString(className);
      UIViewController *viewController        = [[class alloc] init];
      UIImage *image = [UIImage imageNamed:icons[i]];
      NSString *sel = [NSString stringWithFormat:@"%@_",icons[i]];
      UIImage *imageSel = [UIImage imageNamed:sel];
      viewController.tabBarItem.image         = image;
      viewController.tabBarItem.selectedImage = imageSel;
        viewController.tabBarItem.title = titles[i];
      //[viewController.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
       AINavigationController *nav = [[AINavigationController alloc] initWithRootViewController:viewController];
      [viewControllers addObject:nav];
    }
   // [self addTabBar:tabbar];
    
    tabbar.viewControllers = viewControllers;
  });
  return tabbar;
}

+ (void)addTabBar:(AITabBarController*)tabbar
{
  UIImage *select   = [UIImage imageNamed:@"tab_select"];
 // UIImage *selected = [AIHandleImage imageFromColor:[self blackColor17] withFrame:CGRectMake(0, 0, [MainScreen width]/3.0+2, 49)];
 
    
    //选中的背景色
  [tabbar.tabBar setBackgroundImage:select];
  //旋转的字体图标颜色
  [tabbar.tabBar setSelectedImageTintColor:[UIColor whiteColor]];
  //未选中的背景色
  //[tabbar.tabBar setSelectionIndicatorImage:selected];
  
}


#pragma mark -  UITabBarControllerDelegate

//如果在点击选项卡时，当前的导航控制超过了1，则需要返回到当前控制器到首页。
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
   AINavigationController *nav = (AINavigationController *)viewController;
  if (nav.viewControllers.count>1) {
    [nav popToRootViewControllerAnimated:YES];
  }
}

@end
