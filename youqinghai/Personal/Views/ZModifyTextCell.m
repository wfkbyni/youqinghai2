//
//  ZModifyTextCell.m
//  youqinghai
//
//  Created by snailz on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZModifyTextCell.h"

@implementation ZModifyTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.TextBlcok) {
        self.TextBlcok(textField.text);
    }
}
@end
