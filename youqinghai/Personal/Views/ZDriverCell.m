//
//  ZDriverCell.m
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZDriverCell.h"

@implementation ZDriverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDriverMod:(ZDriverModel *)driverMod
{
    _driverMod = driverMod;
    [_icon sd_setImageWithURL:[NSURL URLWithString:driverMod.carphoto]];
    _icon.layer.cornerRadius = 3;
    _carName.text = [NSString stringWithFormat:@"%@  %@座",self.driverMod.carname,self.driverMod.seatsnum];
    _driver.text = [NSString stringWithFormat:@"司机:%@",driverMod.nickname];
    NSString *price = [NSString stringWithFormat:@"￥%@/天",driverMod.dayPrice];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:price];
    [att setAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} range:NSMakeRange(driverMod.dayPrice.length+1, 2)];
    [att setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} range:NSMakeRange(0, 1)];
//     [att setAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(driverMod.dayPrice.length+1, 2)];
    _dayPrice.attributedText =att;
    _sernum.text = [NSString stringWithFormat:@"服务: %@次",driverMod.sernum];
    _eav.text = [NSString stringWithFormat:@"好评: %@%%",driverMod.eav];
    
    if ([driverMod.cartypename isEqualToString:@"舒适型"]) {
        
        _cartypename.layer.borderColor = [UIColor colorWithRed:0.976 green:0.675 blue:0.439 alpha:1.000].CGColor;
        _cartypename.textColor =[UIColor colorWithRed:0.976 green:0.675 blue:0.439 alpha:1.000];
    }
    if ([driverMod.cartypename isEqualToString:@"经济型"]) {
         
        _cartypename.layer.borderColor = [UIColor colorWithRed:0.945 green:0.839 blue:0.475 alpha:1.000].CGColor;
        _cartypename.textColor =[UIColor colorWithRed:0.945 green:0.839 blue:0.475 alpha:1.000];
    }
    if ([driverMod.cartypename isEqualToString:@"豪华型"]) {
        
        _cartypename.layer.borderColor = [UIColor colorWithRed:0.573 green:0.976 blue:0.639 alpha:1.000].CGColor;
        _cartypename.textColor =[UIColor colorWithRed:0.573 green:0.976 blue:0.639 alpha:1.000];
    }
    if ([driverMod.cartypename isEqualToString:@"商务型"]) {
        
        _cartypename.layer.borderColor = [UIColor colorWithRed:0.604 green:0.839 blue:0.976 alpha:1.000].CGColor;
        _cartypename.textColor =[UIColor colorWithRed:0.604 green:0.839 blue:0.976 alpha:1.000];
    }
     _cartypename.layer.borderWidth = 1;
     _cartypename.layer.cornerRadius = 3;
     _cartypename.text =driverMod.cartypename;
}
@end
