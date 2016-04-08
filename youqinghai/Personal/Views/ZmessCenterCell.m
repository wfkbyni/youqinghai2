//
//  ZmessCenterCell.m
//  youqinghai
//
//  Created by snailz on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZmessCenterCell.h"

@implementation ZmessCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
  //  self.selectionStyle  = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setMessMod:(ZUserMessModel *)messMod
{
    _messMod = messMod;
    _title.text = messMod.title;
    _contents.text = messMod.content;
    _time.text =  messMod.addTime;
    
}

@end
