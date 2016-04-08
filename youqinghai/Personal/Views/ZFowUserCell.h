//
//  ZTravelFCell.h
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFowUserCell.h"
#import "ZFowUserModel.h"
//@interface ZTravelFCell : UITableViewCell
@interface ZFowUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *praNum;
@property (weak, nonatomic) IBOutlet UILabel *sign;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIImageView *sex;
@property (weak, nonatomic) IBOutlet UILabel *colleNum;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;
@property(strong,nonatomic) ZFowUserModel *userMod;
@end
