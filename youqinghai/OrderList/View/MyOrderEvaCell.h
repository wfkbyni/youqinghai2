//
//  MyOrderEvaCell.h
//  youqinghai
//
//  Created by snailz on 16/4/14.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStarView.h"
typedef void (^evaNumBlock) (NSInteger);

@interface MyOrderEvaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ZStarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *evaNum;
@property(strong,nonatomic)evaNumBlock evaNumBlock;
@end
