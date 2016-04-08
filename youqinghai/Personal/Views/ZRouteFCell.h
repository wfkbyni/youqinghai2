//
//  ZRouteFCell.h
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRouModel.h"
@interface ZRouteFCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *describe;
@property (weak, nonatomic) IBOutlet UIButton *partake;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *parW;
@property(strong,nonatomic)ZRouModel *rouModel;
@end
