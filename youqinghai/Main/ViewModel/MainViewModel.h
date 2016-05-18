//
//  MainViewModel.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainViewModel : NSObject

@property (nonatomic, assign) NSInteger mark;       // mark 传入  分页时候传入 1
@property (nonatomic, assign) NSInteger typeId;     // 线路类型Id
@property (nonatomic, assign) NSInteger tourisId;   // 线路id
@property (nonatomic, strong) Traveltrip *traveltrip;

@property (nonatomic, assign) NSInteger pageIndex;

//@property (nonatomic, assign) NSInteger routeId;    // 线路Id

// 主页的数据
@property (nonatomic, strong) HomePageData *homePageData;

// 推荐线路
@property (nonatomic, strong) NSMutableArray *recommends;

// 评论列表
@property (nonatomic, strong) NSMutableArray *tourisEvaluate;

/**
 *  @brief 获取首页数据
 *
 */
- (RACSignal *)getHomePageData;

/**
 *  @brief 获取该类型的旅游线路
 *
 */
- (RACSignal *)getTouristroutesList;

/**
 *  @brief 获线路行程介绍（1.0）
 *
 */
- (RACSignal *)getTourisDetails;

/**
 *  @brief 获取该线路的评价（1.0）
 *
 */
- (RACSignal *)getTourisEvaluate;

/**
 *  @brief 获取线路服务介绍（1.0）
 *
 */
- (RACSignal *)getServiceIntroduction;

/**
 *  @brief 添加线路和司机收藏（1.0）
 *  travelId 收藏的司机或线路Id
 *  0：路线，1:司机
 *
 */
-(RACSignal *)addDriverOrRoteIdWithUserId:(NSInteger)userId withTravelId:(NSInteger)travelId withType:(NSInteger)type;

/**
 *  @brief 收藏用户或游记（1.0）
 *
 *  @param userId   用户id
 *  @param travelId 游记Id
 *  @param type     收藏的类型  0 ：游记   1 用户
 *
 */
-(RACSignal *)addTravelsUserCollectionWithUserId:(NSInteger)userId withTravelId:(NSInteger)travelId withType:(NSInteger)type;
@end
