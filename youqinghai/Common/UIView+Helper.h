//
//  UIView+Helper.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/23.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helper)

/**
 *  @brief 设置view圆角
 *
 *  @param cornerRadius <#cornerRadius description#>
 */
- (void)viewWithCornerRadius:(NSInteger)cornerRadius;

/**
 *  @brief 设置view边框
 *
 *  @param border      <#border description#>
 *  @param borderColor <#borderColor description#>
 */
- (void)viewWithBorderWidth:(NSInteger)borderWidth WithBorderColor:(UIColor *)borderColor;

/**
 *  @brief 把图片压缩到指定大小
 *
 *  @param image <#image description#>
 *  @param size  <#size description#>
 *
 *  @return <#return value description#>
 */
- (UIImage *)clipImage:(UIImage *)image toSize:(CGSize)size;

@end
