//
//  CarListCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "CarListCell.h"

@interface CarListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *carphoto;
// 车辆名称
@property (weak, nonatomic) IBOutlet UILabel *carname;
// 司机名
@property (weak, nonatomic) IBOutlet UILabel *nickname;
// 每天价格
@property (weak, nonatomic) IBOutlet UILabel *dayPrice;
// 车辆类型
@property (weak, nonatomic) IBOutlet UILabel *cartypename;
// 服务次数
@property (weak, nonatomic) IBOutlet UILabel *sernum;
// 评价百分比
@property (weak, nonatomic) IBOutlet UILabel *eav;

@end

#define font [UIFont systemFontOfSize:14.0f]

@implementation CarListCell

-(void)awakeFromNib{
    [self.carphoto viewWithCornerRadius:5];
    [self.carname setTextColor:[UIColor colorWithRed:0.08 green:0.08 blue:0.09 alpha:1.00]];
    [self.nickname setTextColor:[UIColor colorWithRed:0.42 green:0.42 blue:0.43 alpha:1.00]];
    [self.sernum setTextColor:[UIColor colorWithRed:0.42 green:0.42 blue:0.43 alpha:1.00]];
    [self.eav setTextColor:[UIColor colorWithRed:0.42 green:0.42 blue:0.43 alpha:1.00]];
    
    [self.dayPrice setTextColor:[UIColor redColor]];
    
    [self.cartypename viewWithBorderWidth:1 WithBorderColor:[UIColor orangeColor]];
    [self.cartypename setTextColor:[UIColor orangeColor]];
    [self.cartypename viewWithCornerRadius:5];
    
    [self.nickname setFont:font];
    [self.dayPrice setFont:font];
    [self.cartypename setFont:font];
    [self.sernum setFont:font];
    [self.eav setFont:font];
}

-(void)setCar:(Car *)car{
    
    [self.carphoto sd_setImageWithURL:[NSURL URLWithString:car.carphoto] placeholderImage:[UIImage imageNamed:@"collection_off"]];
    
    self.carname.text = [NSString stringWithFormat:@"%@ %ld座",car.carname,car.seatsnum];
    self.nickname.text = [NSString stringWithFormat:@"司机: %@",car.nickname];
    self.dayPrice.text = [NSString stringWithFormat:@"￥%ld/天",car.dayPrice];
    self.cartypename.text = car.cartypename;
    self.sernum.text = [NSString stringWithFormat:@"服   务: %ld次",car.sernum];
    self.eav.text = [NSString stringWithFormat:@"好评: %ld%%",car.eav];
    
    [self commonBorderColor:car.cartypename];
}

- (void)commonBorderColor:(NSString *)cartypename{
    UIColor *color;
    if ([cartypename isEqualToString:@"经济型"]) {
        color = [UIColor colorWithRed:0.97 green:0.90 blue:0.56 alpha:1.00];
    }else if([cartypename isEqualToString:@"豪华型"]){
        color = [UIColor colorWithRed:0.44 green:0.96 blue:0.59 alpha:1.00];
    }else if([cartypename isEqualToString:@"商务型"]){
        color = [UIColor colorWithRed:0.68 green:0.88 blue:0.98 alpha:1.00];
    }else if([cartypename isEqualToString:@"舒适型"]){
        color = [UIColor colorWithRed:1.00 green:0.71 blue:0.31 alpha:1.00];
    }
    
    [self.cartypename viewWithBorderWidth:1 WithBorderColor:color];
    [self.cartypename setTextColor:color];
    
}

@end
