//
//  TravelView.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TravelView.h"

@interface TravelView()
// 出游日期
@property (nonatomic, strong) UILabel *travelDate;
// 出游人数
@property (nonatomic, strong) UILabel *travelCount;
// 出游天数
@property (nonatomic, strong) UILabel *travelDay;
@end

@implementation TravelView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        NSArray *titles = @[@"出游日期",@"出游人数",@"出游天数"];
        
        float leftWidth = 110;
        
        [self addSubview:[self lineWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 1)]];
        [self addSubview:[self titleWithFrame:CGRectMake(10, 2, leftWidth, 48) withTitle:titles[0]]];
        _travelDate = [self contentWithFrame:CGRectMake(leftWidth, 2, CGRectGetWidth(self.frame) - leftWidth - 40, 48)];
        [self addSubview:_travelDate];
        [self addSubview:[self rightArrowWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 30 - 8, 10, 30, 30) withTag:1]];
        
        [self addSubview:[self lineWithFrame:CGRectMake(10, 50, CGRectGetWidth(frame) - 20, 1)]];
        [self addSubview:[self titleWithFrame:CGRectMake(10, 52, leftWidth, 48) withTitle:titles[1]]];
        _travelCount = [self contentWithFrame:CGRectMake(leftWidth, 52, CGRectGetWidth(self.frame) - leftWidth - 40, 48)];
        [self addSubview:_travelCount];
        [self addSubview:[self rightArrowWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 30 - 8, 60, 30, 30) withTag:2]];
        
        [self addSubview:[self lineWithFrame:CGRectMake(10, 100, CGRectGetWidth(frame) - 20, 1)]];
        [self addSubview:[self titleWithFrame:CGRectMake(10, 102, leftWidth, 48) withTitle:titles[2]]];
        _travelDay = [self contentWithFrame:CGRectMake(leftWidth, 102, CGRectGetWidth(self.frame) - leftWidth - 40, 48)];
        [self addSubview:_travelDay];
        [self addSubview:[self lineWithFrame:CGRectMake(0, 150, CGRectGetWidth(frame), 1)]];
    }
    
    return self;
}

// 分隔线
- (UIView *)lineWithFrame:(CGRect)frame{
    
    UIView *line = [[UIView alloc] initWithFrame:frame];
    [line setBackgroundColor:[UIColor colorWithRed:0.94 green:0.95 blue:0.95 alpha:1.00]];
    
    return line;
}

// 标题
- (UIView *)titleWithFrame:(CGRect)frame withTitle:(NSString *)title{
    UILabel *titleLab = [[UILabel alloc] initWithFrame:frame];
    [titleLab setFont:[UIFont systemFontOfSize:14.0f]];
    [titleLab setText:title];
    
    return titleLab;
}

// 内容
- (UILabel *)contentWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:[UIFont systemFontOfSize:14.0f]];
    [label setTextAlignment:NSTextAlignmentRight];
    [label setText:@"2015年XX日XX天"];
    return label;
}

// 箭头
- (UIButton *)rightArrowWithFrame:(CGRect)frame withTag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTag:tag];
    [button setBackgroundColor:[UIColor redColor]];
    return button;
}

@end
