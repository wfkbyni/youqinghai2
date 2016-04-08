//
//  ZTextViewCell.m
//  youqinghai
//
//  Created by snailz on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZTextViewCell.h"

@implementation ZTextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placeholder.hidden = NO;
    }else{
        self.placeholder.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.TextBlcok) {
        self.TextBlcok(textView.text);
        
    }
}
@end
