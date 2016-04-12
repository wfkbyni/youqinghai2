//
//  AppDelegate.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "AppDelegate.h"
#import "AITabBarController.h"

#import "TempViewController.h"
  #define AppKey_Umeng @"570b744e67e58e12e2000466"//友盟
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [application setStatusBarHidden:NO];
    [[ZUserModel shareUserModel]  getUserDataWithPhone:@"15928046599" andPassWord:@"123123"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    _window.rootViewController = [AITabBarController  sharedTabbar];
   
//    TempViewController *controller = [[TempViewController alloc] init];
//    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:controller];
//    [self.window setRootViewController:nav];
//    
    [UMSocialData setAppKey:AppKey_Umeng];
    [UMSocialWechatHandler setWXAppId:@"wx43ff5e12f54abd91" appSecret:@"ec07e19c18659631b468724dade4495c" url:@"http://www.wmn.cn/web/lawyer/todown"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1344607825" secret:@"2fe1f9573a6b6759f5d4abb041f3050c" RedirectURL:@"http://wmn.cn"];
    [UMSocialQQHandler setQQWithAppId:@"1105141688" appKey:@"81RIaPqLcKVFXT8I" url:@"http://www.wmn.cn/web/lawyer/todown"];
    
    [UMSocialData defaultData].extConfig.qqData.title = @"游青海";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"游青海";
    [UMSocialData defaultData].extConfig.qzoneData.title = @"游青海";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"游青海";
    [UMSocialData defaultData].extConfig.sinaData.shareText = @"游青海";
    
    [self.window makeKeyAndVisible];
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
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
