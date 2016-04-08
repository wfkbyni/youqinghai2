//
//  RequestBaseAPI+Main.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI.h"

@interface RequestBaseAPI (Main)

/**
 *  @brief 获取首页数据
 *
 *  @param mark      mark 传入  分页时候传入 1
 *  @param pageIndex 页码    （用于推荐线路分页）
 *  @param pageSize  页大小
 *
 */
- (RACSignal *)getHomePageDataWithMark:(NSInteger)mark
                         withPageIndex:(NSInteger)pageIndex
                          withPageSize:(NSInteger)pageSize;

/**
 *  @brief 获取该类型的旅游线路（1.0）
 *
 *  @param typeId    线路类型Id
 *  @param pageIndex <#pageIndex description#>
 *  @param pageSize  <#pageSize description#>
 *
 */
- (RACSignal *)getTouristroutesListWithTypeId:(NSInteger)typeId
                                wihtPageIndex:(NSInteger)pageIndex
                                 withPageSize:(NSInteger)pageSize;

/**
 *  @brief 获线路行程介绍（1.0）
 *
 *  @param tourisId 线路类型Id
 *  @param userId   用户Id
 *
 */
- (RACSignal *)getTourisDetailsWithTourisId:(NSInteger)tourisId withUserId:(NSInteger)userId;

/**
 *  @brief 获取该线路的评价（1.0）
 *
 *  @param tourisId  线路Id
 *  @param pageIndex 页码
 *  @param pageSize  页大小
 *
 */
- (RACSignal *)getTourisEvaluateWithTourisId:(NSInteger)tourisId withPageIndex:(NSInteger)pageIndex withPageSize:(NSInteger)pageSize;

/**
 *  @brief 获取线路服务介绍（1.0）
 *
 *  @param routeId 线路id
 */
- (RACSignal *)getServiceIntroductionWithRouteId:(NSInteger)routeId;

/**
 *  @brief 添加线路和司机收藏（1.0）
 *
 *  @param userId 用户id
 *  @param typeId 收藏的司机或线路Id
 *  @param type 0：路线，1:司机
 *
 */
- (RACSignal *)addDriverOrRoteIdWithUserId:(NSInteger)userId withTypeId:(NSInteger)typeId withType:(NSInteger)type;
@end
