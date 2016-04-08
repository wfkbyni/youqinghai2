//
//  TourisEvaluateCell.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TourisEvaluateCell : UITableViewCell

@property (nonatomic, strong) TourisEvaluate *tourisEvaluate;

/**
 *  @brief 计算row的高度
 *
 *  @param tourisEvaluate <#tourisEvaluate description#>
 *
 *  @return <#return value description#>
 */
+ (CGFloat)cellWithRowHeight:(TourisEvaluate *)tourisEvaluate;

@end
