//
//  ZPageView.m
//  nzls
//
//  Created by snailz on 15/12/7.
//  Copyright © 2015年 raychen. All rights reserved.
//

#import "ZPageView.h"
#import "pageBtn.h"
@interface ZPageView()

@property(nonatomic, strong) CALayer *line;
@property(nonatomic,strong)  pageBtn *btn;
@property(nonatomic,strong)  NSMutableArray *btns;
@end
@implementation ZPageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _btns  = [NSMutableArray array];
        _line = CALayer.new;
        _line.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:_line];
    }
    return self;
}
-(void)setDataS:(NSArray *)dataS
{
    _dataS =dataS;
     [self setBtn];
}
-(void)setBtn
{
    CGFloat btnW = self.frame.size.width/self.dataS.count;
    for (int i  =0; i <self.dataS.count;i++ ) {
        pageBtn *btn = [[pageBtn alloc]initWithFrame:CGRectMake(i*btnW, 0, btnW, self.frame.size.height)];
        [btn setTitle:self.dataS[i] forState:UIControlStateNormal];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        if (i==0) {
            btn.selected=YES;
            //btn.page.hidden = NO;
            self.btn= btn;
        }
        [self.btns addObject:btn];
        [self addSubview:btn];
    }
    CGFloat linkY = (self.frame.size.height-25)/2;
    CGFloat linkX = self.frame.size.width/self.dataS.count;
    for (int i = 0; i<self.dataS.count-1; i++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(linkX*(i+1), linkY, 0.5, 25)];
        view.backgroundColor = [UIColor colorWithWhite:0.898 alpha:1.000];
        [self addSubview:view];
    }
    _line.frame = (CGRect){self.btn.frame.origin.x,self.frame.size.height-1,self.btn.frame.size.width,1};


}
-(void)btnAct:(pageBtn*)btn
{
    self.btn.selected=NO;
    self.btn.page.hidden=YES;
    if (!btn.selected) {
        btn.selected=YES;
        btn.page.hidden = NO;
        self.btn =btn;
    }
    
    _line.frame = (CGRect){self.btn.frame.origin.x,self.frame.size.height-1,self.btn.frame.size.width,1};

    if ([self.delegate respondsToSelector:@selector(pageView:button:)]) {
        [self.delegate pageView:self button:btn];
    }
}
-(void)selectedIndex:(NSNumber*)index
{
    self.btn.selected=NO;
    self.btn.page.hidden=YES;
    pageBtn *btn =  self.btns[index.intValue];
    if (!btn.selected) {
        btn.selected=YES;
        btn.page.hidden = NO;
        self.btn =btn;
        if ([self.delegate respondsToSelector:@selector(pageView:button:)]) {
            [self.delegate pageView:self button:btn];
        }
    }
   _line.frame = (CGRect){self.btn.frame.origin.x,self.frame.size.height-1,self.btn.frame.size.width,1};
}
@end
