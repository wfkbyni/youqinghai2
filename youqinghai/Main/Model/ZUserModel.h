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
-(RACSignal *)getUserDataWithPhone:(NSString*)phone andPassWord:(NSString*)passWord;
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