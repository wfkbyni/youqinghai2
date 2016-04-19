//
//  ZCostomDetModel.h
//  youqinghai
//
//  Created by snailz on 16/4/19.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCostomDetModel : NSObject
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *travelTime;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *travelnum;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *applyTime;
@property(nonatomic,copy)NSString *departure;
@property(nonatomic,copy)NSString *channelscenicspot;
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *destination;
@property(nonatomic,copy)NSString *contacts;
@end
//"id": 定制旅游Id,
//"travelTime": 出游时间,
//"phone": "联系人电话",
//"travelnum": 出游人数,
//"userId": 用户Id,
//"state": 状态,   0：待处理，1：已处理
//"applyTime": 申请时间,
//"departure": "出发地",
//"channelscenicspot": "途径的景点",
//"addTime": 添加时间,
//"destination": "目的地",
//"contacts": "联系人"