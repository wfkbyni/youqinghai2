//
//  ZFowUserModel.h
//  youqinghai
//
//  Created by snailz on 16/4/8.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFowUserModel : NSObject
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *autograph;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *colleNum;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *headUrl;
@property(nonatomic,copy)NSString *praNum;
@end
//"id": 收藏Id,
//"phone": "用户电话",
//"sex": 性别, 0 女 1 男
//"autograph": "用户签名",
//"nickname": "昵称",
//"colleNum": "被赞数",
//"userId": 用户Id,
//"headUrl": "头像路径",
//"praNum": "关注数"