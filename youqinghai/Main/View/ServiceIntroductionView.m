//
//  ServiceIntroductionView.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/29.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ServiceIntroductionView.h"

@implementation ServiceIntroductionView

-(void)setContent:(NSString *)content{
    CGFloat height = [content calHeightWithWidth:kScreenSize.width - 40 withFontSize:16];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, kScreenSize.width - 40, height)];
    [label setNumberOfLines:0];
    [label setFont:[UIFont systemFontOfSize:16.0f]];
    [label setText:content];
    
    [self addSubview:label];
    
    [self setContentSize:CGSizeMake(kScreenSize.width, height + 40)];
}

@end
