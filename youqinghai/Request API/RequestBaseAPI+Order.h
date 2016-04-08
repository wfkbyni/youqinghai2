//
//  RequestBaseAPI+Order.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI.h"

@interface RequestBaseAPI (Order)

/**
 *  @brief 计算包车订单价格（1.0）
 *
 *  @param traveId         景点Id
 *  @param withIsInsurance 车辆类型Id
 *  @param isInsurance     是否购买保险(保险人数)
 *
 */
- (RACSignal *)calcCharteredPriceWithTraveId:(NSInteger)traveId
                               withCarTypeId:(NSInteger)carTypeId
                             withIsInsurance:(NSInteger)isInsurance;

/**
 *  @brief 生成支付订单（1.0）
 *
 *  @param orderModel 提交的实体数据
 *
 */
- (RACSignal *)addOrderWithOrder:(Order *)order;

@end
