//
//  RequestBaseAPI+Car.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI.h"

@interface RequestBaseAPI (Car)

/**
 *  @brief 获取包车的车辆信息（1.0）
 *
 *  @param cartypeId  车辆类型Id
 *  @param eavnum     评论排序 0：升序 1：降序
 *  @param priceState 价格排序  0:从低到高   1：从高到低
 *  @param tourId     出游路线Id
 *  @param travelTime 出发时间  （时间戳）
 *  @param pageIndex  页码
 *  @param pageSize   页大小
 *
 */
- (RACSignal *)getCarListWithCartypeId:(NSInteger)cartypeId
                            wihtEavnum:(NSInteger)eavnum
                        withPriceState:(NSInteger)priceState
                            withTourId:(NSInteger)tourId
                        withTravelTime:(long)travelTime
                         withPageIndex:(NSInteger)pageIndex
                          withPageSize:(NSInteger)pageSize;


/**
 *  @brief 获取车辆类型（1.0）
 *
 */
- (RACSignal *)getCarTypeList;

/**
 *  @brief 获取司机车辆详情（1.0）
 *
 *  @param driverId 司机Id
 *  @param userId   <#userId description#>
 *
 */
- (RACSignal *)getDriverCarDetailsWithDriverId:(NSInteger)driverId withUserId:(NSInteger)userId;
@end
