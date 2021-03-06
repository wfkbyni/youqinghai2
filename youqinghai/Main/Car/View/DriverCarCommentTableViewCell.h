//
//  DriverCarCommentTableViewCell.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/4.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectBlock)(NSInteger);

@interface DriverCarCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *evalist;
@property(strong,nonatomic)selectBlock selectBlock;
/**
 *  @brief 计算行高
 *
 *  @param eav <#eav description#>
 *
 *  @return <#return value description#>
 */
+(float)calcCellHeight:(Eav *)eav;

@end
