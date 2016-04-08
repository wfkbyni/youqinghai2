//
//  ZDriverModel.h
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDriverModel : NSObject
@property(nonatomic,copy)NSString *travelTime;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *seatsnum;
@property(nonatomic,copy)NSString *sernum;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *cartypename;
@property(nonatomic,copy)NSString *driverId;
@property(nonatomic,copy)NSString *eav;
@property(nonatomic,copy)NSString *carname;
@property(nonatomic,copy)NSString *dayPrice;
@property(nonatomic,copy)NSString *carphoto;
@end
//"id": 车辆信息Id,
//"travelTime": 出游时间,
//"seatsnum": 座位数,
//"sernum": 服务次数,
//"nickname": "司机昵称",
//"cartypename": "车辆类型名称",
//"driverId": 司机Id,
//"eav": 评论数,
//"carname": "车辆名称",
//"dayPrice": 每天价格,
//"carphoto": "车辆图片"