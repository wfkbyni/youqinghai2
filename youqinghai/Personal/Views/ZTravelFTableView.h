//
//  ZTravelFTableView.h
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTravelFCell.h"
typedef void (^selectBlock)(NSIndexPath*);
@interface ZTravelFTableView : UITableView
@property(strong,nonatomic)selectBlock selectBlock;
@property(nonatomic,strong)NSMutableArray *tabAr;
@end
