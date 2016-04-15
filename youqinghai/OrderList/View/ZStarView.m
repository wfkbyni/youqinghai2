//
//  ZStarView.m
//  timeText
//
//  Created by HY007 on 15/8/20.
//  Copyright (c) 2015年 HY007. All rights reserved.
//

#import "ZStarView.h"
 
@interface ZStarView()
@end
@implementation ZStarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setStar];
        self.bounds = CGRectMake(0, 0, 15*5, 15);
        self.userInteractionEnabled=NO;
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setStar];
    
    self.bounds = CGRectMake(0, 0, 15*5, 15);
}
-(void)setDelegate:(id<ZStarViewDelagete>)delegate
{
    _delegate=delegate;
   
}
-(void)setStar
{
    CGFloat starW = 15;
    for (int i = 0;  i<5; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*starW, 0, starW, starW)];
        [button setImage:[UIImage imageNamed:@"nullstar"] forState:UIControlStateNormal];
        button.tag =i+1;
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
-(void)clickBtn:(UIButton*)button
{
    self.starCount=button.tag;
    if ([self.delegate respondsToSelector:@selector(ZStarView:clickButton:)]) {
        [self.delegate ZStarView:self clickButton:button];
    }
}
-(void)setStarCount:(CGFloat)starCount
{
    _starCount = starCount;
    int stars = starCount;
    for (int i = 0; i<5; i++) {
        UIButton *button = (UIButton*)self.subviews[i];
        [button setImage:[UIImage imageNamed:@"nullstar"] forState:UIControlStateNormal];
    }
    for (int i = 0; i<stars; i++) {
        UIButton *button = (UIButton*)self.subviews[i];
        [button setImage:[UIImage imageNamed:@"fullstar"] forState:UIControlStateNormal];
    }
    if (starCount-stars != 0 ) {
        UIButton *button = (UIButton*)self.subviews[stars];
        [button setImage:[UIImage imageNamed:@"genstar"] forState:UIControlStateNormal];
    }
}
@end
