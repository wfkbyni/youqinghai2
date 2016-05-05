//
//  AppDelegate.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "AppDelegate.h"
#import "AITabBarController.h"
#import <SDWebImage/SDWebImageDownloader.h>
#import "TempViewController.h"
  #define AppKey_Umeng @"570b744e67e58e12e2000466"//友盟
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [application setStatusBarHidden:NO];
    [[ZUserModel shareUserModel]  getUserDataWithPhone:@"15882407060" andPassWord:@"123456"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    _window.rootViewController = [AITabBarController  sharedTabbar];
 
//    TempViewController *controller = [[TempViewController alloc] init];
//    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:controller];
//    [self.window setRootViewController:nav];
//    
    [UMSocialData setAppKey:AppKey_Umeng];
   
//    [UMSocialWechatHandler setWXAppId:@"wxeb076ac34fb771b7" appSecret:@"6dc56b5630579fa7d4b614edabfa3434" url:@"http://www.wmn.cn/web/lawyer/todown"];
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1799384586" secret:@"dc96ffc3a2ca7eeb3f8e8c63d8493d9f" RedirectURL:@"http://wmn.cn"];
//    [UMSocialQQHandler setQQWithAppId:@"1105195687" appKey:@"1Mj6wJJiiYtLZJaJ" url:@"http://www.wmn.cn/web/lawyer/todown"];
    
    [self.window makeKeyAndVisible];
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == NO) {
        result = [AISharedPay handleOpenURL:url];
        
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == NO) {
        result = [AISharedPay handleOpenURL:url];
        
    }
    return result;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
