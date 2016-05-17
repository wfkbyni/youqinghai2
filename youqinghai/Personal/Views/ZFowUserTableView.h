//
//  ZFowUserTableView.h
//  youqinghai
//
//  Created by snailz on 16/4/8.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFowUserCell.h"
typedef void (^selectBlock)(NSIndexPath*);
@interface ZFowUserTableView : UITableView
@property(strong,nonatomic)selectBlock selectBlock;

@property(nonatomic,strong)NSMutableArray *tabAr;
@end
