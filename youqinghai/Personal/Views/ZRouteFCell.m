//
//  ZRouteFCell.m
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZRouteFCell.h"

@implementation ZRouteFCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _icon.layer.cornerRadius = 3;
    _partake.layer.cornerRadius = 25/2;
    // Initialization code
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGRect temp = self.contentView.frame;
    temp.origin.x = 10;
    temp.size.width=screen.width;
    temp.size.width-=20;
    self.contentView.frame = temp;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setRouModel:(ZRouModel *)rouModel
{
    _rouModel =rouModel;
    [_icon sd_setImageWithURL:[NSURL URLWithString:rouModel.imgUrl]];
    _title.text = rouModel.title;
    _describe.text = rouModel.introduce;
    [_partake setTitle:[NSString stringWithFormat:@"参与: %@",rouModel.partake] forState:UIControlStateNormal];
    [_partake sizeToFit];
    _parW.constant = _partake.frame.size.width+12;
}
@end
