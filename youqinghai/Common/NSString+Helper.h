//
//  NSString+Helper.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/29.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

/**
 *  @brief 计算字符串的高度
 *
 *  @param str   需要计算的字符串
 *  @param width view的宽度
 *  @param fontSize  字体大小
 *
 *  @return 字符串的高度
 */
- (CGFloat)calHeightWithWidth:(CGFloat)width withFontSize:(NSInteger)fontSize;
    
@end
