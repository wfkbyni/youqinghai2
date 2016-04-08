//
//  OrderViewModel.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderViewModel : NSObject

@property (nonatomic, strong) Order *order;

// 景点Id
@property (nonatomic, assign) NSInteger traveId;
// 车辆类型Id
@property (nonatomic, assign) NSInteger carTypeId;

/**
 *  @brief 计算包车订单价格（1.0）
 *
 */
- (RACSignal *)calcCharteredPrice;

/**
 *  @brief 生成支付订单（1.0）
 *
 */
- (RACSignal *)addOrder;

@end
