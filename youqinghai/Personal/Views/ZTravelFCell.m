//
//  ZTravelFCell.m
//  youqinghai
//
//  Created by snailz on 16/4/8.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZTravelFCell.h"

@implementation ZTravelFCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _userIcon.layer.cornerRadius = _userIcon.frame.size.height/2;
    _TrImage.layer.cornerRadius =3;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setTravelMod:(ZTravelModel *)travelMod
{
    _travelMod = travelMod;
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:travelMod.headUrl]];
    
    _time.text = travelMod.addTime;
    
    [_views setTitle:[NSString stringWithFormat:@" %@",travelMod.views] forState:UIControlStateNormal];
    [_views sizeToFit];
    _viewsW.constant = _views.frame.size.width;
    
    [_TrImage  sd_setImageWithURL:[NSURL URLWithString:travelMod.imgUrl]];
    
    _content.text = travelMod.content;
    [_content sizeToFit];
    _contentW.constant = _content.frame.size.height;
    
    [_parNum setTitle:[NSString stringWithFormat:@" %@",travelMod.parNum] forState:UIControlStateNormal];
    _nickName.text = travelMod.nickname;
}
/**
 *  点赞操作
 *
 *  @param sender <#sender description#>
 */
- (IBAction)parAct:(id)sender {
}
/**
 *  评论操作
 *
 *  @param sender <#sender description#>
 */
- (IBAction)commentsAct:(id)sender {
}
/**
 *  分享操作
 *
 *  @param sender <#sender description#>
 */
- (IBAction)sharAct:(id)sender {
}

@end
