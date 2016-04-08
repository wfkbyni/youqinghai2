//
//  CheckBoxView.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "CheckBoxView.h"

@interface CheckBoxView(){
    UIButton *noBtn;
    UIButton *yesBtn;
}
@end

@implementation CheckBoxView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _checked = YES;
        yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [yesBtn setFrame:CGRectMake(0, 10, 60, 28)];
        [yesBtn setTitle:@"是" forState:UIControlStateNormal];
        [yesBtn setTag:CheckBoxVeiwWithYES];
        [yesBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [yesBtn setTitleColor:[UIColor colorWithRed:0.42 green:0.42 blue:0.43 alpha:1.00] forState:UIControlStateNormal];
        [self addSubview:yesBtn];
        
        noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [noBtn setFrame:CGRectMake(CGRectGetMaxX(yesBtn.frame) + 10, 10, 60, 28)];
        [noBtn setTitle:@"否" forState:UIControlStateNormal];
        [noBtn setTag:CheckBoxVeiwWithNO];
        [noBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [noBtn setTitleColor:[UIColor colorWithRed:0.42 green:0.42 blue:0.43 alpha:1.00] forState:UIControlStateNormal];
        [self addSubview:noBtn];
        
        [self statusValue];
    }
    return self;
}

- (void)btnAction:(UIButton *)sender{
    switch (sender.tag) {
        case CheckBoxVeiwWithYES:
            self.checked = YES;
            [self statusValue];
            break;
        case CheckBoxVeiwWithNO:
            self.checked = NO;
            [self statusValue];
            break;
        default:
            break;
    }
    
    if (_btnClickEvent) {
        _btnClickEvent(self);
    }
}

- (void)statusValue{
    if (self.checked) {
        [yesBtn setImage:[UIImage imageNamed:@"check_on"] forState:UIControlStateNormal];
        [noBtn setImage:[UIImage imageNamed:@"check_off"] forState:UIControlStateNormal];
    }else{
        [yesBtn setImage:[UIImage imageNamed:@"check_off"] forState:UIControlStateNormal];
        [noBtn setImage:[UIImage imageNamed:@"check_on"] forState:UIControlStateNormal];

    }
}

@end
