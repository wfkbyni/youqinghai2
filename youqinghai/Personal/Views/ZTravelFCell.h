//
//  ZTravelFCell.h
//  youqinghai
//
//  Created by snailz on 16/4/8.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTravelModel.h"
@interface ZTravelFCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *views;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewsW;
@property (weak, nonatomic) IBOutlet UIImageView *TrImage;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentW;
@property (weak, nonatomic) IBOutlet UIButton *parNum;
@property (weak, nonatomic) IBOutlet UIButton *parBtn;
@property(strong,nonatomic)ZTravelModel *travelMod;
@end
