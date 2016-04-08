//
//  CarViewModel.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarViewModel : NSObject

@property (nonatomic, assign) NSInteger cartypeId;     // 车辆类型Id
@property (nonatomic, assign) NSInteger eavnum;        // 评论排序 0：升序 1：降序
@property (nonatomic, assign) NSInteger priceState;    // 价格排序  0:从低到高   1：从高到低
@property (nonatomic, assign) NSInteger tourId;        // 出游路线Id
@property (nonatomic, assign) NSInteger travelTime;    // 出发时间  （时间戳）

@property (nonatomic, assign) NSInteger driverId;      // 司机id
@property (nonatomic, strong) CarDetail *carDetail;

// 车辆列表
@property (nonatomic, strong) NSArray *cars;
// 车辆类型
@property (nonatomic, strong) NSArray *carTypes;

/**
 *  @brief 获取包车的车辆信息（1.0）
 *
 */
- (RACSignal *)getCarList;

/**
 *  @brief 获取车辆类型（1.0）
 *
 */
- (RACSignal *)getCarTypeList;

/**
 *  @brief 获取司机车辆详情（1.0）
 *
 */
- (RACSignal *)getDriverCarDetails;

@end
