//
//  ZTravelFCell.m
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZFowUserCell.h"

@implementation ZFowUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _icon.layer.cornerRadius = 80/2;
    // Initialization code
}
-(void)setUserMod:(ZFowUserModel *)userMod
{
    _userMod = userMod;
    [_icon sd_setImageWithURL:[NSURL URLWithString:userMod.headUrl]];
    
    if (userMod.sex.integerValue==0) {
        _sex.image = [UIImage imageNamed:@"我的_我的关注_关注游记_03"];
    }else{
        _sex.image = [UIImage imageNamed:@"首页_线路分类_详情_包车_车辆详情---副本_06"];
    }
    _name.text = userMod.nickname;
    [_name sizeToFit];
    _width.constant = _name.bounds.size.width;
    
    _sign.text = userMod.autograph;
    
    _colleNum.text = [NSString stringWithFormat:@"被赞: %@",userMod.colleNum];
    
    _phone.text =[userMod.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    _praNum.text = [NSString stringWithFormat:@"关注 :%@",userMod.praNum];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
