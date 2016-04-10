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
                               withCarTypeId:(NSInteger)driverId
                             withIsInsurance:(NSInteger)isInsurance;

/**
 *  @brief 计算拼车价格
 *
 *  @param traveId 景点id
 *
 */
- (RACSignal *)calcPriceWithTraveId:(NSInteger)traveId;

/**
 *  @brief 生成支付订单（1.0）
 *
 *  @param orderModel 提交的实体数据
 *
 */
- (RACSignal *)addOrderWithOrder:(Order *)order;

/**
 *  获取订单列表
 *
 *  @param userId    <#userId description#>
 *  @param state     <#state description#>
 *  @param pageIndex <#pageIndex description#>
 *  @param pageSize  <#pageSize description#>
 *
 *  @return <#return value description#>
 */
-(RACSignal *)getUserOrderList:(NSInteger)userId
                     wihtState:(NSInteger)state
                 withPageIndex:(NSInteger)pageIndex
                  withPageSize:(NSInteger)pageSize;
/**
 *  获取订单详情
 *
 *  @param orderId <#orderId description#>
 *
 *  @return <#return value description#>
 */
-(RACSignal *)getUserOrderDetailOrderId:(NSString*)orderId;
@end
