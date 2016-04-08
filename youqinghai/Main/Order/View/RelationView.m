//
//  RelationView.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RelationView.h"
#import "CheckBoxView.h"

@interface RelationView()

@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;
@property (nonatomic, strong) UITextField *textField3;
@property (nonatomic, strong) UITextField *textField4;

@end

@implementation RelationView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        NSArray *titles = @[@"联系人",@"联系电话",@"紧急联系人",@"紧急联系人电话",@"是否购买保险"];
        NSArray *placeholders = @[@"请填写联系人姓名",@"请填写联系人电话",@"请填写紧急联系人姓名",@"请填写紧急联系人电话",@""];
        float leftWidth = 110;
        
        [self addSubview:[self lineWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 1)]];
        [self addSubview:[self titleWithFrame:CGRectMake(10, 2, leftWidth, 48) withTitle:titles[0]]];
        _textField1 = [self textFieldWithFrame:CGRectMake(leftWidth + 10, 2, CGRectGetWidth(self.frame) - leftWidth - 20, 48) withPlaceholder:placeholders[0]];
        [self addSubview:_textField1];
        
        [self addSubview:[self lineWithFrame:CGRectMake(10, 50, CGRectGetWidth(frame) - 20, 1)]];
        [self addSubview:[self titleWithFrame:CGRectMake(10, 52, leftWidth, 48) withTitle:titles[1]]];
        _textField2 = [self textFieldWithFrame:CGRectMake(leftWidth + 10, 52, CGRectGetWidth(self.frame) - leftWidth - 20, 48) withPlaceholder:placeholders[1]];
        [self addSubview:_textField2];
        
        [self addSubview:[self lineWithFrame:CGRectMake(10, 100, CGRectGetWidth(frame) - 20, 1)]];
        [self addSubview:[self titleWithFrame:CGRectMake(10, 102, leftWidth, 48) withTitle:titles[2]]];
        _textField3 = [self textFieldWithFrame:CGRectMake(leftWidth + 10, 102, CGRectGetWidth(self.frame) - leftWidth - 20, 48) withPlaceholder:placeholders[2]];
        [self addSubview:_textField3];
        
        [self addSubview:[self lineWithFrame:CGRectMake(10, 150, CGRectGetWidth(frame) - 20, 1)]];
        [self addSubview:[self titleWithFrame:CGRectMake(10, 152, leftWidth, 48) withTitle:titles[3]]];
        _textField4 = [self textFieldWithFrame:CGRectMake(leftWidth + 10, 152, CGRectGetWidth(self.frame) - leftWidth - 20, 48) withPlaceholder:placeholders[3]];
        [self addSubview:_textField4];
        
        [self addSubview:[self lineWithFrame:CGRectMake(10, 200, CGRectGetWidth(frame) - 20, 1)]];
        [self addSubview:[self titleWithFrame:CGRectMake(10, 202, leftWidth, 48) withTitle:titles[4]]];
        CheckBoxView *checkBox = [[CheckBoxView alloc] initWithFrame:CGRectMake(leftWidth + 10, 202, CGRectGetWidth(self.frame) - leftWidth - 20, 48)];
        [self addSubview:checkBox];
        [self addSubview:[self lineWithFrame:CGRectMake(0, 250, CGRectGetWidth(frame), 1)]];
        
        [self bindModel];
    }
    
    return self;
}

-(void)setOrder:(Order *)order{
    _order = order;
}

- (void)bindModel{
    [_textField1.rac_textSignal subscribeNext:^(id x) {
        self.order.contacts = x;
    }];
    
    [_textField2.rac_textSignal subscribeNext:^(id x) {
        self.order.contactsTel = x;
    }];
    
    [_textField3.rac_textSignal subscribeNext:^(id x) {
        self.order.urgent = x;
    }];
    
    [_textField3.rac_textSignal subscribeNext:^(id x) {
        self.order.urgentTel = x;
    }];
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

// 输入框
- (UITextField *)textFieldWithFrame:(CGRect)frame withPlaceholder:(NSString *)placeholder{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    [textField setBorderStyle:UITextBorderStyleNone];
    [textField setFont:[UIFont systemFontOfSize:14.0f]];
    [textField setPlaceholder:placeholder];
    [self addSubview:textField];
    
    return textField;
}

@end
