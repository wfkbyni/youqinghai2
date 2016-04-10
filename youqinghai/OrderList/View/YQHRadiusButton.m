//
//  YQHRadiusButton.m
//  youqinghai
//
//  Created by mouxiaochun on 16/4/9.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "YQHRadiusButton.h"

@implementation YQHRadiusButton
+ (YQHRadiusButton *)createWithTitle:(NSString *)title withColor:(UIColor *)color{

    YQHRadiusButton *bt = [YQHRadiusButton buttonWithType:UIButtonTypeCustom];
    bt.frame = (CGRect){CGPointZero,78,33};
    bt.layer.cornerRadius = 4;
    bt.layer.borderColor  = color.CGColor;
    bt.layer.borderWidth  = .5;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:color forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:15];
    return bt;
}
@end
