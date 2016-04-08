//
//  ZDriverCell.h
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDriverModel.h"
@interface ZDriverCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *carName;
@property (weak, nonatomic) IBOutlet UILabel *driver;
@property (weak, nonatomic) IBOutlet UILabel *dayPrice;
@property (weak, nonatomic) IBOutlet UILabel *sernum;
@property (weak, nonatomic) IBOutlet UILabel *cartypename;
@property (weak, nonatomic) IBOutlet UILabel *eav;
@property(strong,nonatomic)ZDriverModel *driverMod;
@end
