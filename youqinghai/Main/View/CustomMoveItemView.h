//
//  CustomMoveItemView.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/26.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TourismDetailType) {
    TourismDetailTypeWithIntroduction,  // 行程介绍
    TourismDetailTypeWithEvaluate,      // 线路评价
    TourismDetailTypeWithService        // 服务介绍
};

@interface CustomMoveItemView : UIView

/**
 *  @brief 自定义滑动的view
 *
 *  @param frame <#frame description#>
 *  @param items <#items description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame withItems:(NSArray *)items;

@property (nonatomic, copy) void(^CustoMoveItemBlock)(TourismDetailType type,UILabel *lab);

@end
