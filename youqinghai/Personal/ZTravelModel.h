//
//  ZTravelModel.h
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTravelModel : NSObject
@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *sernum;
@property(nonatomic,copy)NSString *parNum;
@property(nonatomic,copy)NSString *views;
@property(nonatomic,copy)NSString *driverId;
@property(nonatomic,copy)NSString *headUrl;
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *height;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *isPraise;
@property(nonatomic,copy)NSString *IsFollow;
@end
//"imgUrl": "游记图片路径",
//"content": "游记内容",
//"id": 游记Id,
//"parNum": 被赞数,
//"views": 浏览数,
//"headUrl": "用户头像路径",
//"addTime": 添加时间


//"imgUrl": "图片",
//"content": "游记内容",
//"isPraise": "是否点赞", 1 是 0 否
//"nickname": "用户昵称",
//"views": 浏览量,
//"userId": 用户Id,
//"IsFollow": 是否关注", 1 是 0 否
//"praise": 被赞数,
//"headUrl": "用户头像",
//"travelsId": 游记Id,
//"addTime": 添加时间