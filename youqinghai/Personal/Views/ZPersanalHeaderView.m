//
//  ZPersanalHeaderView.m
//  youqinghai
//
//  Created by snailz on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZPersanalHeaderView.h"
#import "ZUserModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZPersonalDataViewController.h"
@interface ZPersanalHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *praiseNum;
@property (weak, nonatomic) IBOutlet UILabel *followNum;
@property (weak, nonatomic) IBOutlet UILabel *travelNum;
@property (weak, nonatomic) IBOutlet UILabel *UserSign;
@property (weak, nonatomic) IBOutlet UILabel *UserPhone;

@property (weak, nonatomic) IBOutlet UIImageView *UserIcon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameW;
@property (weak, nonatomic) IBOutlet UIImageView *sexIcon;

@property (weak, nonatomic) IBOutlet UIButton *UserName;
@end
@implementation ZPersanalHeaderView
-(void)awakeFromNib
{
    ZUserModel *user = [ZUserModel shareUserModel];
 
    if (![ZUserModel shareUserModel].userId) {
        [_UserName setTitle:@"请登录" forState:UIControlStateNormal];
        [_UserName sizeToFit];
        _nameW.constant = _UserName.bounds.size.width;
        _UserSign.text = @"快来登录,开始您的旅程!";
        _sexIcon.image = nil;
        _UserPhone.text = @"";
        _UserIcon.layer.cornerRadius = _UserIcon.bounds.size.height/2;
        _UserIcon.layer.borderWidth = 2;
        _UserIcon.layer.borderColor = [UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000].CGColor;
        _travelNum.text = user.travelCount;
        
        _followNum.text = user.collection;
        
        _praiseNum.text = user.parise;
        return;
    }
    [_UserName setTitle:user.nickname forState:UIControlStateNormal];
    [_UserName sizeToFit];
    _nameW.constant = _UserName.bounds.size.width;
 
    if (user.sex.integerValue==0) {
        _sexIcon.image = [UIImage imageNamed:@"我的_我的关注_关注游记_03"];
    }else{
         _sexIcon.image = [UIImage imageNamed:@"首页_线路分类_详情_包车_车辆详情---副本_06"];
    }
    
    [_UserIcon sd_setImageWithURL:[NSURL URLWithString:user.headUrl]];
    //[_UserIcon sd_setImageWithURL:[NSURL URLWithString:user.headUrl] placeholderImage:[UIImage imageNamed:@"游记_03"]];
    _UserIcon.layer.cornerRadius = _UserIcon.bounds.size.height/2;
    _UserIcon.layer.borderWidth = 2;
    _UserIcon.layer.borderColor = [UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000].CGColor;
    //_UserIcon.layer.masksToBounds = YES;
    
    
    _UserPhone.text = [user.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
   
    _UserSign.text = [NSString stringWithFormat:@"“%@”", user.autograph];
    
    _travelNum.text = user.travelCount;
    
    _followNum.text = user.collection;
    
    _praiseNum.text = user.parise;
    

}

- (IBAction)pushInfoAct:(id)sender {
    if (_btnBlcok) {
        self.btnBlcok();
    }

}
@end
