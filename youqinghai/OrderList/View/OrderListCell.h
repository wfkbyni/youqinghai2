//
//  OrderListCell.h
//  youqinghai
//
//  Created by mouxiaochun on 16/4/8.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

typedef NS_ENUM(NSInteger, OrderType) {
    OrderTypeWithCancel,        // 取消订单
    OrderTypeWithConfirmPay,    // 立即支付
    OrderTypeWithComplaintPay,  // 投诉司机
    OrderTypeWithComplete,      // 完成出游
    OrderTypeWithEvaluate,      // 立即评价
    OrderTypeWithDeleteOrder    // 删除订单
};

@interface OrderListCell : UITableViewCell
@property(strong,nonatomic)OrderListModel *orderListMod;

@property (nonatomic, copy) void (^btnClickType)(OrderType);
@end
