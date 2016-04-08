//
//  RelationView.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RelationView.h"
#import "CheckBoxView.h"
#import "CalculateView.h"

@interface RelationView()

@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;
@property (nonatomic, strong) UITextField *textField3;
@property (nonatomic, strong) UITextField *textField4;
@property (nonatomic, strong) UILabel *personLabelCount;
@property (nonatomic, strong) UILabel *fuseMoneyLab;
@property (nonatomic, strong) UILabel *fuseTotalMoneyLab;

@property (nonatomic, strong) CalculateView *calculateView;

@end

@implementation RelationView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        NSArray *titles = @[@"联系人",@"联系电话",@"紧急联系人",@"紧急联系人电话",@"是否购买保险",@"添加保险人信息",@"保险金额"];
        NSArray *placeholders = @[@"请填写联系人姓名",@"请填写联系人电话",@"请填写紧急联系人姓名",@"请填写紧急联系人电话",@"",@""];
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
        [self addSubview:[self lineWithFrame:CGRectMake(10, 250, CGRectGetWidth(frame) - 20, 1)]];
        
        [self addSubview:[self lineWithFrame:CGRectMake(10, 250, CGRectGetWidth(frame) - 20, 1)]];
        [self addSubview:[self titleWithFrame:CGRectMake(10, 250 + 2, leftWidth, 48) withTitle:titles[5]]];
        _personLabelCount = [self contentWithFrame:CGRectMake(leftWidth, 250 + 2, CGRectGetWidth(self.frame) - leftWidth - 30, 48)];
        [self addSubview:_personLabelCount];
        [self addSubview:[self rightArrowWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 30, 260, 30, 30) withTag:2]];
        
        [self addSubview:[self lineWithFrame:CGRectMake(10, 301, CGRectGetWidth(frame) - 20, 1)]];
        
        _fuseMoneyLab = [self titleWithFrame:CGRectMake(10, 315, 150, 25) withTitle:@""];
        [_fuseMoneyLab setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:_fuseMoneyLab];
        
        _fuseTotalMoneyLab = [self titleWithFrame:CGRectMake(CGRectGetWidth(self.frame) / 2, 315, CGRectGetWidth(self.frame) / 2 - 10, 25) withTitle:@""];
        [_fuseTotalMoneyLab setTextAlignment:NSTextAlignmentRight];
        [_fuseTotalMoneyLab setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:_fuseTotalMoneyLab];
        
        [self addSubview:self.calculateView];
        
        __weak typeof(RelationView *) weakSelf = self;
        void (^calHeightBlock)(BOOL) = ^(BOOL checked){
            CGRect frame = weakSelf.frame;
            float height = checked ? 7 * 50 : 5 * 50;
            frame.size.height = height + CGRectGetHeight(self.calculateView.frame);
            weakSelf.frame = frame;
            
            frame = weakSelf.calculateView.frame;
            frame.origin.y = height;
            weakSelf.calculateView.frame = frame;
        };
        
        [checkBox setBtnClickEvent:^(CheckBoxView *sender) {
            calHeightBlock(sender.checked);
        }];
        
        calHeightBlock(checkBox.checked);
        
        [self bindModel];
    }
    
    return self;
}

-(void)setOrder:(Order *)order{
    _order = order;
    
    [self attrString];
}

-(void)setCalCarPrice:(CalCarPrice *)calCarPrice{
    _calCarPrice = calCarPrice;
    
    
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

- (void)attrString{
    
    NSMutableAttributedString *fuseMoneyAttr = [[NSMutableAttributedString alloc] init];
    
    [fuseMoneyAttr appendAttributedString:[[NSAttributedString alloc] initWithString:@"保险金额:" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}]];
    
    [fuseMoneyAttr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f/天",_order.insuranceCost] attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}]];
    
    self.fuseMoneyLab.attributedText = fuseMoneyAttr;
    
    NSMutableAttributedString *fuseTotalMoneyAttr = [[NSMutableAttributedString alloc] init];
    
    [fuseTotalMoneyAttr appendAttributedString:[[NSAttributedString alloc] initWithString:@"总金额:" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}]];
    
    [fuseTotalMoneyAttr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f",_order.insuranceCost * _order.insuranceData.count] attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}]];
    
    self.fuseTotalMoneyLab.attributedText = fuseTotalMoneyAttr;
    
    
    NSMutableAttributedString *orderMoneyAttr = [[NSMutableAttributedString alloc] init];
    
    [orderMoneyAttr appendAttributedString:[[NSAttributedString alloc] initWithString:@"订单金额:" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}]];
    
    [orderMoneyAttr appendAttributedString:[[NSAttributedString alloc] initWithString:@"￥150/天" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}]];
    
    self.calculateView.orderMoneyLab.attributedText = orderMoneyAttr;
    
    NSMutableAttributedString *orderTotalMoneyAttr = [[NSMutableAttributedString alloc] init];
    
    [orderTotalMoneyAttr appendAttributedString:[[NSAttributedString alloc] initWithString:@"总金额:" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}]];
    
    [orderTotalMoneyAttr appendAttributedString:[[NSAttributedString alloc] initWithString:@"￥300000.00" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}]];
    
    self.calculateView.totalMoneyLab.attributedText = orderTotalMoneyAttr;
}

// 分隔线
- (UIView *)lineWithFrame:(CGRect)frame{
    
    UIView *line = [[UIView alloc] initWithFrame:frame];
    [line setBackgroundColor:[UIColor colorWithRed:0.94 green:0.95 blue:0.95 alpha:1.00]];
    
    return line;
}

// 标题
- (UILabel *)titleWithFrame:(CGRect)frame withTitle:(NSString *)title{
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

// 内容
- (UILabel *)contentWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:[UIFont systemFontOfSize:14.0f]];
    [label setTextAlignment:NSTextAlignmentRight];
    [label setText:@"3人"];
    return label;
}

// 箭头
- (UIButton *)rightArrowWithFrame:(CGRect)frame withTag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTag:tag];
    [button setImage:[UIImage imageNamed:@"icon_rightArrow"] forState:UIControlStateNormal];
    return button;
}



- (CalculateView *)calculateView{
    if (!_calculateView) {
        _calculateView = [[CalculateView alloc] initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame) - 130, kScreenSize.width, 120)];
    }
    return _calculateView;
}
@end
