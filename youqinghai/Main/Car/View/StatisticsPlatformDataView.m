//
//  StatisticsPlatformDataView.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/17.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "StatisticsPlatformDataView.h"

@interface StatisticsPlatformDataView()
@property (nonatomic, strong) UILabel *successReserveLab;   // 成功预订
@property (nonatomic, strong) UILabel *joinCarLab;          // 加入车辆
@property (nonatomic, strong) UILabel *transactionMoneyLab; // 交易金额
@end

@implementation StatisticsPlatformDataView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [maskView setBackgroundColor:[UIColor blackColor]];
        [maskView setAlpha:0.8];
        [self addSubview:maskView];
        
        CGFloat width = CGRectGetWidth(frame) / 3;
        
        _successReserveLab = [self commonLabWithFrame:CGRectMake(0, 0, width, CGRectGetHeight(frame) / 2) withType:YES withTitle:@"2"];
        UILabel *label = [self commonLabWithFrame:CGRectMake(0, CGRectGetHeight(frame) / 2, width, CGRectGetHeight(frame) / 2) withType:NO withTitle:@"成功预订"];
        [self addSubview:_successReserveLab];
        [self addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(width, 10, 0.5, CGRectGetHeight(frame) - 20)];
        [line setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:line];
        
        _joinCarLab = [self commonLabWithFrame:CGRectMake(width, 0, width, CGRectGetHeight(frame) / 2) withType:YES withTitle:@"3"];
        label = [self commonLabWithFrame:CGRectMake(width, CGRectGetHeight(frame) / 2, width, CGRectGetHeight(frame) / 2) withType:NO withTitle:@"加入车辆"];
        [self addSubview:_joinCarLab];
        [self addSubview:label];
        
        line = [[UIView alloc] initWithFrame:CGRectMake(width * 2, 10, 0.5, CGRectGetHeight(frame) - 20)];
        [line setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:line];
        
        _transactionMoneyLab = [self commonLabWithFrame:CGRectMake(width * 2, 0, width, CGRectGetHeight(frame) / 2) withType:YES withTitle:@"4"];
        label = [self commonLabWithFrame:CGRectMake(width * 2, CGRectGetHeight(frame) / 2, width, CGRectGetHeight(frame) / 2) withType:NO withTitle:@"交易金额"];
        [self addSubview:_transactionMoneyLab];
        [self addSubview:label];
        
    }
    return self;
}

- (void)setStatisticsPlatformData:(NSString *)statisticsPlatformData{
    StatisticsPlatformData *data = [StatisticsPlatformData mj_objectWithKeyValues:statisticsPlatformData];
    _successReserveLab.text = [NSString stringWithFormat:@"%ld",data.successReserve];
    _joinCarLab.text = [NSString stringWithFormat:@"%ld",data.joinCar];
    _transactionMoneyLab.text = [NSString stringWithFormat:@"%ld",data.transactionMoney];
}

- (UILabel *)commonLabWithFrame:(CGRect)frame withType:(BOOL)fontFlag withTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setText:title];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    if (fontFlag) {
        [label setTextColor:[UIColor orangeColor]];
        [label setFont:[UIFont boldSystemFontOfSize:15.0f]];
    }else{
        
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:14.0f]];
    }
    return label;
}

@end

@implementation StatisticsPlatformData

@end
