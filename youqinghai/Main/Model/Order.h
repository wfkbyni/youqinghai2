//
//  Order.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property (nonatomic, assign) NSInteger userId;     // 用户Id
@property (nonatomic, assign) NSInteger traveld;    // 旅游线路Id
@property (nonatomic, assign) NSInteger carTypeId;  // 车辆类型Id
@property (nonatomic, assign) long travelTime;      // 出游日期
@property (nonatomic, assign) NSInteger travelnum;  // 出游人数
@property (nonatomic, copy) NSString *contacts;     // 联系人
@property (nonatomic, copy) NSString *contactsTel;  // 联系人电话
@property (nonatomic, copy) NSString *urgent;       // 紧急联系人
@property (nonatomic, copy) NSString *urgentTel;    // 紧急联系人电话
@property (nonatomic, assign) CGFloat insuranceCost; // 保险费用( 人数 )
@property (nonatomic, assign) CGFloat orderMoney;
@property (nonatomic, assign) CGFloat orderReserve;  // 预定金额
@property (nonatomic, strong) NSArray *insuranceData;   // 保险人
@property (nonatomic, assign) NSInteger traveltype;  // 0拼车，1包车
@property (nonatomic, assign) NSInteger driverId;    // 司机id

/*
insuranceData
Json数据格式
[
 {
     "userName": "呵呵",
     "cardNum": "6565546"
 },
 {
     "userName": "邹何燕",
     "cardNum": "6565546554654"
 }
 ]
*/

@end

@interface InsuranceData : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *cardNum;

@end

@interface CalCarPrice : NSObject

//{"matchingValue":"20","orderPrice":200,"orderReserve":20,"isInsuranceMoney":"0"}
@property (nonatomic, strong) NSNumber *matchingValue;      // 系统配置保险金额
@property (nonatomic, strong) NSNumber *orderPrice;         // 订单总价格
@property (nonatomic, strong) NSNumber *orderReserve;       // 预付金额
@property (nonatomic, strong) NSString *isInsuranceMoney;   // 保险金额

@end

@interface CalcPrice : NSObject
@property (nonatomic, strong) NSNumber *travelTime;         // 出游时间
@property (nonatomic, strong) NSNumber *perPrice;           // 每人价格,
@property (nonatomic, strong) NSNumber *deposit;            // 预付定金,
@property (nonatomic, strong) NSNumber *mathchValue;        // 系统保险金额
@property (nonatomic, strong) NSArray *listType;            //
//"listType": [
//             {
//                 "id": 车辆类型Id,
//                 "seatsnum": 座位数,
//                 "cartypename": "车辆类型",
//                 "dayPrice": 每天价格
//             }
//             ],
@property (nonatomic, strong) NSNumber *travePersonNum;      // 出游人数,
@property (nonatomic, strong) NSNumber *orderPrice;          // 订单总额,
@property (nonatomic, strong) NSNumber *day;                 // 出游天数,
@property (nonatomic, strong) NSNumber *isInsuranceMoney;    // 保险金额"
@end
