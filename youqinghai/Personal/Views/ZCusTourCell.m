//
//  ZCusTourCell.m
//  youqinghai
//
//  Created by snailz on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZCusTourCell.h"

@implementation ZCusTourCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setListModel:(ZCustomListModel *)listModel
{
    _listModel = listModel;
    _applyTime.text = [NSString stringWithFormat:@"申请时间: %@",listModel.applyTime];
    _goTime.text = [NSString stringWithFormat:@"出游时间: %@",listModel.travelTime];
   _goNum.text =[NSString stringWithFormat:@"出游人数: %@人",listModel.travelnum];
    _contacts.text =[NSString stringWithFormat:@"联系人: %@",listModel.contacts];
}
@end
