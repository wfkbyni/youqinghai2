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
@end
//"imgUrl": "游记图片路径",
//"content": "游记内容",
//"id": 游记Id,
//"parNum": 被赞数,
//"views": 浏览数,
//"headUrl": "用户头像路径",
//"addTime": 添加时间