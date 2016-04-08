//
//  NSString+Helper.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/29.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

- (CGFloat)calHeightWithWidth:(CGFloat)width withFontSize:(NSInteger)fontSize{
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    return MAX(21, round(rect.size.height + 0.5));
}

@end
