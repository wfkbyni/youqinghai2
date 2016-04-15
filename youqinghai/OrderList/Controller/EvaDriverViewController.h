//
//  EvaDriverViewController.h
//  youqinghai
//
//  Created by snailz on 16/4/14.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
@interface EvaDriverViewController : UIViewController
@property(strong,nonatomic)OrderListModel *listMod;
@property(assign,nonatomic)CGFloat height;
@property(nonatomic,strong)NSMutableArray *images;
@property(nonatomic,copy)NSString *orderStr;
@property(nonatomic,assign)NSInteger orderlevel;
@property(strong,nonatomic)NSArray *orderImage;
@property(nonatomic,getter=isEva)BOOL eva;
@end
