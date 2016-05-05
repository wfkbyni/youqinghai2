//
//  OrderListModel.h
//  youqinghai
//
//  Created by snailz on 16/4/9.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListModel : NSObject
@property(strong,nonatomic)NSString *travelTime;
@property(strong,nonatomic)NSString *nickname;
@property(strong,nonatomic)NSString *urgent;
@property(strong,nonatomic)NSString *state;
@property(strong,nonatomic)NSString *ordernum;
@property(strong,nonatomic)NSString *orderNum;

@property(strong,nonatomic)NSString *carname;
@property(strong,nonatomic)NSString *orderReserve;
@property(strong,nonatomic)NSString *contactsTel;
@property(strong,nonatomic)NSString *insuranceCost;
@property(strong,nonatomic)NSString *contacts;
@property(strong,nonatomic)NSString *ID;
@property(strong,nonatomic)NSString *urgentTel;
@property(strong,nonatomic)NSString *tourName;
@property(strong,nonatomic)NSString *carnum;
@property(strong,nonatomic)NSString *carTypeName;
@property(strong,nonatomic)NSString *carType;
@property(strong,nonatomic)NSString *singletime;
@property(strong,nonatomic)NSString *traveltype;
@property(strong,nonatomic)NSString *traveld;
 @property(strong,nonatomic)NSString *imgUrl;
 @property(strong,nonatomic)NSString *travelnum;
@property(strong,nonatomic)NSString *orderId;
@property(strong,nonatomic)NSString *dayNum;
@property(strong,nonatomic)NSString *orderMoney;
@property(strong,nonatomic)NSString *Typename;
@property (strong, nonatomic) NSString *phone;
@end
//"travelTime": 出游时间,
//"nickname": "司机呢称",
//"urgent": "紧急联系人",
//"state":状态,
//订单状态(0：待付款，1：待完成，2：待评价，3：已完成，4：取消订单)
//"orderNum": "订单号",
//"carname": "车辆名称",
//"orderReserve":预定金额,
//"contactsTel": "联系人电话",
//"insuranceCost": "是否购买保险", 0否1是
//"contacts": 联系人,
//"id": 订单Id,
//"urgentTel": "紧急联系人电话",
//"tourName": "青海异地",
//"travelnum": 出游人数,
//"carnum": "车牌号",
//"carTypeName": "车辆类型",
//"singletime": 下单时间,
//"traveltype":出游方式  （0：拼车，1：包车）
//"traveld": 线路Id

 
//"travelTime": 出游时间,
//"nickname": "司机名称",
//"urgent": "紧急联系人",
//"state": 订单状态,
//"carname": "车辆名称",
//"orderReserve": 预定金额,
//"contactsTel": "联系人电话",
//"insuranceCost": "是否购买保险", .0 ：未购买1：已购买
//"contacts": 联系人,
//"id": 订单Id,
//"urgentTel": "紧急联系人电哈",
//"travelnum": 出游人数,
//"carnum": "车牌号",
//"singletime": 下单时间,
//"traveltype": 出游方式  （0：拼车，1：包车）
//"traveld": 出游方式  线路Id
//"dayNum": 出游天数