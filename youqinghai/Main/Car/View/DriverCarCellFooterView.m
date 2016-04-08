//
//  DriverCarCellFooterView.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/4.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "DriverCarCellFooterView.h"

@implementation DriverCarCellFooterView

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withIsShowLine:(BOOL)isShowLine{

    if (self = [super initWithFrame:frame]) {
        
        if (isShowLine) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 1, kScreenSize.width - 20, 0.5)];
            [line setBackgroundColor:[UIColor grayColor]];
            [self addSubview:line];
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:button];
    }
    return self;
}

@end
