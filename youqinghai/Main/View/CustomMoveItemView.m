//
//  CustomMoveItemView.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/26.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "CustomMoveItemView.h"

@interface CustomMoveItemView(){
    NSInteger oldSelectIndex;
}
// 显示的项
@property (nonatomic, strong) NSArray *showItems;
@end

#define SelectColor [UIColor colorWithRed:0.24 green:0.70 blue:0.95 alpha:1.00]

@implementation CustomMoveItemView

-(instancetype)initWithFrame:(CGRect)frame withItems:(NSArray *)items{
    
    if (self = [super initWithFrame:frame]) {
        NSAssert(items, @"items not nil");
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        float width = kScreenSize.width / items.count;
        
        for (int i = 0; i < items.count; i++) {

            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(i * width, 0, width, CGRectGetHeight(frame))];
            lab.text = items[i];
            [lab setFont:[UIFont systemFontOfSize:15.0f]];
            lab.tag = i;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.userInteractionEnabled = YES;
            
            UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake((i + 1) * width + 1, 10, 1, CGRectGetHeight(frame) - 20)];
            [vLine setBackgroundColor:[UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00]];
            
            if (i == 0) {
                [lab setTextColor:SelectColor];
                
                UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(20 + i * width, CGRectGetHeight(frame) - 2, width - 40, 2)];
                [hLine setBackgroundColor:SelectColor];
                hLine.tag = 1001;
                
                [self addSubview:hLine];
            }else{
                [lab setTextColor:[UIColor grayColor]];
            }
            
            [self addSubview:lab];
            [self addSubview:vLine];
            
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTouchAction:)];
            [lab addGestureRecognizer:gesture];
            
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame) - 1, CGRectGetWidth(frame), 1)];
        [line setBackgroundColor:[UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00]];
        [self addSubview:line];
    }
    return self;
}

- (void)viewTouchAction:(UITapGestureRecognizer *)sender{
    
    if (_CustoMoveItemBlock) {
        
        void (^changeSelectViewColor)() = ^(){
            [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[UILabel class]]) {
                    UILabel *lab = obj;
                    if (lab.tag == sender.view.tag) {
                        [lab setTextColor:SelectColor];
                    }else{
                        [lab setTextColor:[UIColor grayColor]];
                    }
                }else{
                    if (obj.tag == 1001) {
                        [UIView animateWithDuration:0.25 animations:^{
                            CGRect frame = obj.frame;
                            frame.origin.x = sender.view.frame.origin.x + 20;
                            frame.size.width = CGRectGetWidth(sender.view.frame) - 40;
                            
                            obj.frame = frame;
                        }];
                    }
                }
                
            }];
        };
        
        changeSelectViewColor();
        
        NSInteger tag = sender.view.tag;
        
        if (oldSelectIndex == tag && oldSelectIndex != 2 && oldSelectIndex != 1 && oldSelectIndex != 3) {
            return;
        }else{
            oldSelectIndex = tag;
            _CustoMoveItemBlock(tag,(UILabel *)sender.view);
        }
    }
    
}

@end
