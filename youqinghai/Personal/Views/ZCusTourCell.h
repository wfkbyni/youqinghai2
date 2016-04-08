//
//  ZCusTourCell.h
//  youqinghai
//
//  Created by snailz on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCustomListModel.h"
@interface ZCusTourCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *applyTime;
@property (weak, nonatomic) IBOutlet UILabel *goTime;
@property (weak, nonatomic) IBOutlet UILabel *goNum;
@property (weak, nonatomic) IBOutlet UILabel *contacts;
@property(strong,nonatomic)ZCustomListModel *listModel;
@end
