//
//  MyOrderEvaViewController.h
//  youqinghai
//
//  Created by snailz on 16/4/14.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
@interface MyOrderEvaViewController : BaseViewController
@property(strong,nonatomic)OrderListModel *listMod;
@property(assign,nonatomic)CGFloat height;
@property(nonatomic,strong)NSMutableArray *images;
@end
