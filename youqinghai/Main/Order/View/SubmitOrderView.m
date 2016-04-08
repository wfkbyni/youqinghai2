//
//  SubmitOrderView.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "SubmitOrderView.h"

@interface SubmitOrderView()
@property (nonatomic, strong) UIButton *submitOrderBtn;
@property (nonatomic, strong) UILabel *totalMoneyLab;
@end

@implementation SubmitOrderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, 40, CGRectGetHeight(frame))];
        [label setFont:[UIFont systemFontOfSize:15.0f]];
        [label setTextColor:[UIColor blackColor]];
        [label setText:@"合计:"];
        [self addSubview:label];
        
        _totalMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1, 200, CGRectGetHeight(frame))];
        [_totalMoneyLab setFont:[UIFont systemFontOfSize:18.0f]];
        [_totalMoneyLab setTextColor:[UIColor colorWithRed:0.94 green:0.38 blue:0.16 alpha:1.00]];
        [_totalMoneyLab setText:@"￥15000.00"];
        [self addSubview:_totalMoneyLab];
        
        _submitOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 150, 0, 150, CGRectGetHeight(self.frame))];
        [_submitOrderBtn setBackgroundColor:[UIColor orangeColor]];
        [_submitOrderBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitOrderBtn addTarget:self action:@selector(submitOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_submitOrderBtn];
    }
    return self;
}

- (void)submitOrderAction:(UIButton *)sender{
    if (_SubmitOrderAction) {
        _SubmitOrderAction();
    }
}
@end
