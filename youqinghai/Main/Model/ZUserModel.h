//
//  ZUserModel.h
//  youqinghai
//
//  Created by snailz on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBaseAPI+User.h"
/**
 *  用户信息
 */
@interface ZUserModel : NSObject
@property(nonatomic,copy)NSString *parise; //被赞次数
@property(nonatomic,copy)NSString *sex; 
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *travelCount;
@property(nonatomic,copy)NSString *autograph;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *headUrl;
@property(nonatomic,copy)NSString *collection;
@property(nonatomic,copy)NSString *passWord;
+(instancetype)shareUserModel;
/**
 *  登录账号
 *
 *  @param phone    账号
 *  @param passWord 密码
 *
 *  @return <#return value description#>
 */
-(RACSignal *)getUserDataWithPhone:(NSString*)phone andPassWord:(NSString*)passWord;
/**
 *  判断是否登录
 *
 *  @param controller 控制器
 *
 *  @return <#return value description#>
 */
+(BOOL)pushLogin:(UIViewController*)controller;
/**
 *  判断是否登录,已登录则返回用户ID，未登陆不需要进入登录页面
 *
 *  @param controller 控制器
 *
 *  @return <#return value description#>
 */
+ (NSString *)getUserIdNeedLogin:(UIViewController*)controller;
@end
//{"parise":0,"sex":1,"phone":"13458540072","travelCount":0,"autograph":"帅哥就是你","nickname":"你很帅","userId":4,"headUrl":"http://img.smartmiyi.com/userHeadUrl/1457678872657__headimage.jpg","collection":0}
//"parise":被赞次数,
//"travelCount": 出游次数,
//"phone": "联系电话",
//"sex": "性别", 0女  1男
//"autograph": "用户签名",
//"nickname": "昵称",
//"userId": 用户Id,
//"collection": 收藏数,
//"headUrl": "用户头像路径"