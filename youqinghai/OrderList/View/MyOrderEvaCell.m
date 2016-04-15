//
//  MyOrderEvaCell.m
//  youqinghai
//
//  Created by snailz on 16/4/14.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "MyOrderEvaCell.h"
@interface MyOrderEvaCell()<ZStarViewDelagete>
@end
@implementation MyOrderEvaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.starView.delegate =self;
    self.selectionStyle = 0;
    // Initialization code
}
-(void)ZStarView:(ZStarView *)starView clickButton:(UIButton *)button
{
    self.evaNum.text = [@(button.tag).stringValue stringByAppendingString:@".0分"];
    if (self.evaNumBlock) {
        self.evaNumBlock(button.tag);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
