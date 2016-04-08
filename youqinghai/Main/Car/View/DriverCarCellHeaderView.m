//
//  DriverCarCellHeaderView.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/4.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "DriverCarCellHeaderView.h"

@implementation DriverCarCellHeaderView

-(instancetype)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName withTitle:(NSString *)title{
    frame = CGRectMake(0, 0, kScreenSize.width, 50);
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        [imageView setImage:[UIImage imageNamed:imageName]];
        
        [self addSubview:imageView];
        
        UILabel *label =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 10, 15, 200, 20)];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setTextColor:[UIColor grayColor]];
        [label setText:title];
        
        [self addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(frame) - 5, kScreenSize.width - 20, 0.5)];
        [line setBackgroundColor:[UIColor grayColor]];
        [self addSubview:line];
    }
    return self;
}

@end
