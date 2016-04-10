//
//  TravelView.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

typedef NS_ENUM(NSInteger,TravelType) {
    TravelTypeWithDate,    //  出游日期
    TravelTypeWithCount,   //  出游人数
    TravelTypeWithDay,     //  出游天数
    TravelTypeWithType     //  拼车类型
};

@interface TravelView : UIView

/**
 *  @brief <#Description#>
 *
 *  @param frame   <#frame description#>
 *  @param isTrave 是否拼车
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame withIsTrave:(BOOL)isTrave;

@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, strong) CalcPrice *calcPrice;

@property (nonatomic, copy) void (^TravelSelectBlock)(TravelType type,id value);

@property (nonatomic, strong) CarDetail *carDetail;

@property (nonatomic, assign) NSInteger seatsnum;    // 出游人数
@property (nonatomic, assign) NSInteger viewlist;    // 出游天数
@end
