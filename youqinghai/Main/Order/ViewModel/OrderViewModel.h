//
//  OrderViewModel.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderListModel.h"
@interface OrderViewModel : NSObject

@property (nonatomic, strong) Order *order;

// 景点Id
@property (nonatomic, assign) NSInteger traveId;
// 车辆类型Id
@property (nonatomic, assign) NSInteger driverId;

@property (nonatomic, strong) CalCarPrice *calCarPrice;

@property (nonatomic, strong) CalcPrice *cPrice;

@property (nonatomic, strong) NSArray *orders;
@property (nonatomic, strong) NSArray *orderList;
@property(nonatomic,copy) NSString *pages;

/**
 *  @brief 计算包车订单价格（1.0）
 *
 */
- (RACSignal *)calcCharteredPrice;

- (RACSignal *)calcPrice;

/**
 *  @brief 生成支付订单（1.0）
 *
 */
- (RACSignal *)addOrder;
/**
 *  获取订单列表
 *
 *  @return <#return value description#>
 */
-(RACSignal *)getUserOrderList:(NSInteger)state;
/**
 *  获取订单详情
 *
 *  @return <#return value description#>
 */
-(RACSignal *)getUserOrderDetail:(NSString*)orderId;

/**
 *  @brief 支付
 *
 *  @param orderNo <#orderNo description#>
 *  @param money   <#money description#>
 */
-(RACSignal *)notifyUrlWithOrderNo:(NSString *)orderNo withTotalMoney:(NSString *)money;

/**
 *  @brief 取消订单
 *
 *  @param orderNo <#orderNo description#>
 *
 */
-(RACSignal *)cancelOrderWithOrderNo:(NSString *)orderNo;

-(RACSignal *)deleteOrder:(NSString *)orderId;
@end
