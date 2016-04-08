//
//  Car.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (nonatomic, assign) NSInteger Id;         // 车辆Id
@property (nonatomic, assign) NSInteger seatsnum;   // 座位数
@property (nonatomic, assign) NSInteger sernum;     // 服务次数
@property (nonatomic, copy) NSString *nickname;     // 司机名
@property (nonatomic, copy) NSString *cartypename;  // 车辆类型
@property (nonatomic, assign) NSInteger eav;        // 评价百分比
@property (nonatomic, copy) NSString *carname;      // 车辆名称
@property (nonatomic, assign) NSInteger dayPrice;   // 每天价格
@property (nonatomic, copy) NSString *carphoto;     // 车辆图片
@property (nonatomic, copy) NSString *travelTime;   // 出发时间

@end

@interface CarType : NSObject

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString *cartypename;

@end
