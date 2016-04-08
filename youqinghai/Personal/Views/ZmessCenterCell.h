//
//  ZmessCenterCell.h
//  youqinghai
//
//  Created by snailz on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUserMessModel.h"
@interface ZmessCenterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *contents;
@property (weak, nonatomic) IBOutlet UILabel *time;
 
@property(strong,nonatomic)ZUserMessModel *messMod;
@end
