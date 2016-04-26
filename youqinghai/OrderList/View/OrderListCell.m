//
//  OrderListCell.m
//  youqinghai
//
//  Created by mouxiaochun on 16/4/8.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "OrderListCell.h"
#import "YQHRadiusButton.h"
@interface OrderListCell ()

{
    UIView      *_subView;
    UIImageView *_picIV;
    UILabel     *_titleLB; //标题，如青海一日游
    UILabel     *_tourDateLB; //出游日期
    UILabel     *_tourNumLB; //出游人数
    UILabel     *_carTypeLB; //车辆类型
    UILabel     *_moneyLB;  //定金
    
    
    UIView      *_bottomSubView;
    UILabel     *_tourTypeLB;//包车、拼车 出游类型
    
    
    YQHRadiusButton *_cancelBT;
    YQHRadiusButton *_confirmPayBT;
    
    CGFloat _cancelX,_confirmX;
    
}

@end

@implementation OrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self commonInit];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)commonInit {

    _subView = UIView.new;
    _subView.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
    [self.contentView addSubview:_subView];
    
    _picIV = UIImageView.new;
    _picIV.image = [UIImage imageNamed:@"02"];
    _picIV.clipsToBounds=YES;
    _picIV.layer.cornerRadius = 3;
    [_subView addSubview:_picIV];
    
    
    _titleLB = UILabel.new;
    _titleLB.font = [UIFont systemFontOfSize:15];
    _titleLB.text = @"青海三日游";
    _titleLB.textColor = [UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000];
    [_subView addSubview:_titleLB];
    
    _tourDateLB = UILabel.new;
    _tourDateLB.text = @"出游日期:2016-01-01";
    _tourDateLB.font = [UIFont systemFontOfSize:12];
    _tourDateLB.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    [_subView addSubview:_tourDateLB];
    
    
    _tourNumLB = UILabel.new;
    _tourNumLB.text = @"出游人数: 3人";
    _tourNumLB.font = [UIFont systemFontOfSize:12];
    _tourNumLB.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    _tourNumLB.textAlignment =NSTextAlignmentRight;
    [_tourNumLB sizeToFit];
    [_subView addSubview:_tourNumLB];
    
    
    _carTypeLB = UILabel.new;
    _carTypeLB.text = @"车辆类型: 经济型";
    _carTypeLB.font = [UIFont systemFontOfSize:12];
    _carTypeLB.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    [_subView addSubview:_carTypeLB];
    
    
    _moneyLB = UILabel.new;
    _moneyLB.text = @"定金: ￥83";
    _moneyLB.font = [UIFont systemFontOfSize:12];
    _moneyLB.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    _moneyLB.textAlignment = NSTextAlignmentRight;
    [_moneyLB sizeToFit];
    [_subView addSubview:_moneyLB];
    
    
    _bottomSubView = UIView.new;
    [self.contentView addSubview:_bottomSubView];
    
    _tourTypeLB = UILabel.new;
    _tourTypeLB.font = [UIFont systemFontOfSize:16];
    _tourTypeLB.text = @"包车出游";
    [_bottomSubView addSubview:_tourTypeLB];
    
    UIColor *color = [UIColor redColor];
    
    _confirmPayBT = [YQHRadiusButton createWithTitle:@"立即支付" withColor:color];
    _confirmPayBT.tag = OrderTypeWithConfirmPay;
    [_confirmPayBT addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
   //
    [_bottomSubView addSubview:_confirmPayBT];
    
    
    color = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    
    _cancelBT = [YQHRadiusButton createWithTitle:@"取消订单" withColor:color];
    _cancelBT.tag = OrderTypeWithCancel;
    [_cancelBT addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomSubView addSubview:_cancelBT];
    
    self.contentView.backgroundColor = [UIColor  whiteColor];
    self.textLabel.text = @"2015-01-01 11:50:30";
    self.textLabel.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];
    self.textLabel.font = [UIFont systemFontOfSize:13];
    
    self.detailTextLabel.text = @"代付款";
    self.detailTextLabel.textColor = [UIColor redColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:13];
    
}

- (void)btnAction:(UIButton *)sender{
    if (_btnClickType) {
        _btnClickType(sender.tag);
    }
}


- (void)layoutSubviews {

    [super layoutSubviews];
    CGFloat leftEdge = 10.0;
    
    CGRect frame   = self.textLabel.frame;
    frame.origin.x = leftEdge;
    frame.origin.y = 10.0f;
    self.textLabel.frame = frame;
    
    frame = self.detailTextLabel.frame;
    frame.origin.x = self.frame.size.width - frame.size.width - leftEdge;
    frame.origin.y = self.textLabel.frame.origin.y;
    self.detailTextLabel.frame = frame;
    
    _subView.frame = (CGRect){0,self.textLabel.relativeY+5,self.width  ,134};
    
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    if (w>350) {
        _picIV.frame = (CGRect){leftEdge,10.0f,150,112};
    }else{
        _picIV.frame = (CGRect){leftEdge,10.0f,112,112};
    }
    
    CGFloat x    = _picIV.relativeX+5;
    _titleLB.frame    = (CGRect){x,_picIV.y,self.width - x,20};
    
    _tourDateLB.frame = (CGRect){_titleLB.x,_titleLB.relativeY+15,145,20};

    _carTypeLB.frame  = (CGRect){_titleLB.x,_picIV.height-25,_tourDateLB.size};

    _tourNumLB.frame  = (CGRect){self.width-_tourNumLB.width-5,_tourDateLB.y,_tourNumLB.width,_tourDateLB.height};
    _moneyLB.frame    = (CGRect){self.width-_moneyLB.width-5,_carTypeLB.y,_moneyLB.width,_tourDateLB.height};
    
    _bottomSubView.frame = (CGRect){0,_subView.relativeY,self.width,53};
    _tourTypeLB.frame    = (CGRect){leftEdge,0,80,_bottomSubView.height};
    
    [_confirmPayBT setOrigin:CGPointMake(self.width - _confirmPayBT.width-10,(_bottomSubView.height - _confirmPayBT.height)/2)];
    [_cancelBT setOrigin:CGPointMake(_confirmPayBT.x-_confirmPayBT.width - 5,_confirmPayBT.y)];

    _cancelX = _cancelBT.x;
    _confirmX = _confirmPayBT.x;
    
    if (YES == _confirmPayBT.hidden) {
        [_cancelBT setX:_confirmX];
    }else{
        [_cancelBT setX:_cancelX];
    }
}
-(void)setOrderListMod:(OrderListModel *)orderListMod
{
    _orderListMod = orderListMod;
    self.textLabel.text = orderListMod.singletime;
    NSLog(@"%@",orderListMod.singletime);
    [_cancelBT setHidden:NO];
    [_confirmPayBT setHidden:NO];
    switch (orderListMod.state.integerValue) {
        case 0:
            self.detailTextLabel.text = @"待付款";
            [_cancelBT setTitle:@"取消订单" forState:UIControlStateNormal];
            [_confirmPayBT setTitle:@"立即支付" forState:UIControlStateNormal];
            _cancelBT.tag = OrderTypeWithCancel;
            _confirmPayBT.tag = OrderTypeWithConfirmPay;
            break;
        case 1:
            self.detailTextLabel.text = @"待完成";
            [_cancelBT setTitle:@"投诉司机" forState:UIControlStateNormal];
            [_confirmPayBT setTitle:@"完成出游" forState:UIControlStateNormal];
            _cancelBT.tag = OrderTypeWithComplaintPay;
            _confirmPayBT.tag = OrderTypeWithComplete;
            _confirmPayBT.hidden = YES;
            break;
        case 2:
            self.detailTextLabel.text = @"待评价";
            [_confirmPayBT setTitle:@"立即评价" forState:UIControlStateNormal];
            [_cancelBT setHidden:YES];
            _confirmPayBT.tag = OrderTypeWithEvaluate;
          
            break;
        case 3:
            self.detailTextLabel.text = @"已完成";
            [_confirmPayBT setTitle:@"删除订单" forState:UIControlStateNormal];
            [_cancelBT setHidden:YES];
            _confirmPayBT.tag = OrderTypeWithDeleteOrder;
          
            break;
        case 4:
            self.detailTextLabel.text = @"取消订单";
            [_confirmPayBT setTitle:@"删除订单" forState:UIControlStateNormal];
            [_cancelBT setHidden:YES];
            _confirmPayBT.tag = OrderTypeWithDeleteOrder;
            break;
        default:
            break;
    }
    [_picIV sd_setImageWithURL:[NSURL URLWithString:orderListMod.imgUrl]];
    
    _titleLB.text = orderListMod.Typename;
    
    _tourDateLB.text = [NSString stringWithFormat:@"出游日期:%@",orderListMod.travelTime];
    
    _tourNumLB.text = [NSString stringWithFormat:@"出游人数: %@",orderListMod.travelnum];
    _carTypeLB.text = [NSString stringWithFormat:@"车辆类型:%@", orderListMod.carType];
    _moneyLB.text = [NSString stringWithFormat:@"定金: %@",orderListMod.orderReserve];
    _tourTypeLB.text = orderListMod.traveltype.integerValue?@"包车出游":@"拼车出游";
}
@end
