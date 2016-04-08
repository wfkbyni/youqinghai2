//
//  CalculateView.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "CalculateView.h"

@interface CalculateView()
// 订单金额
@property (nonatomic, strong) UILabel *orderMoneyLab;
// 总金额
@property (nonatomic, strong) UILabel *totalMoneyLab;
// 订金
@property (nonatomic, strong) UILabel *earnestMoneyLab;
@end

@implementation CalculateView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:[self lineWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 1)]];
        _orderMoneyLab = [self labelWithFrame:CGRectMake(10, 10, 150, 25) withTitle:@"订单金额:1500/天" withColor:[UIColor orangeColor]];
        [_orderMoneyLab setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:_orderMoneyLab];
        
        _totalMoneyLab = [self labelWithFrame:CGRectMake(CGRectGetWidth(self.frame) / 2, 10, CGRectGetWidth(self.frame) / 2 - 10, 25) withTitle:@"总金额:￥150000.00" withColor:[UIColor orangeColor]];
        [_totalMoneyLab setTextAlignment:NSTextAlignmentRight];
        [_totalMoneyLab setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:_totalMoneyLab];
        
        [self addSubview:[self labelWithFrame:CGRectMake(10, 35, CGRectGetWidth(self.frame), 25) withTitle:@"(订单总金额包括过路费、油费，不包含吃、住、门票等费用)" withColor:[UIColor blackColor]]];
        
        [self addSubview:[self lineWithFrame:CGRectMake(10, 60, CGRectGetWidth(frame) - 20, 1)]];

        [self addSubview:[self labelWithFrame:CGRectMake(10, 70, 150, 25) withTitle:@"需预付定金" withColor:[UIColor blackColor]]];
        _earnestMoneyLab = [self labelWithFrame:CGRectMake(CGRectGetWidth(self.frame) / 2, 70, CGRectGetWidth(self.frame) / 2 - 10, 25) withTitle:@"￥1500.00" withColor:[UIColor orangeColor]];
        [_earnestMoneyLab setTextAlignment:NSTextAlignmentRight];
        [_earnestMoneyLab setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:_earnestMoneyLab];
        
        [self addSubview:[self labelWithFrame:CGRectMake(10, 95, CGRectGetWidth(self.frame), 25) withTitle:@"(定金支付后将不再退还、出游中有相关疑问请联系平台客服)" withColor:[UIColor blackColor]]];
        
        [self addSubview:[self lineWithFrame:CGRectMake(0, 119, CGRectGetWidth(frame), 1)]];
    }
    
    return self;
}

// 分隔线
- (UIView *)lineWithFrame:(CGRect)frame{
    
    UIView *line = [[UIView alloc] initWithFrame:frame];
    [line setBackgroundColor:[UIColor colorWithRed:0.94 green:0.95 blue:0.95 alpha:1.00]];
    
    return line;
}

- (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title withColor:(UIColor *)color{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:[UIFont systemFontOfSize:12.0f]];
    [label setText:title];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setTextColor:color];
    
    return label;
}
@end
