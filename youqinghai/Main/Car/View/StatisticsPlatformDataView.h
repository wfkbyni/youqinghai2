//
//  StatisticsPlatformDataView.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/17.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticsPlatformDataView : UIView

@property (nonatomic, copy) NSString *statisticsPlatformData;

@end

@interface StatisticsPlatformData : NSObject

@property (nonatomic, assign) NSInteger joinCar;            // 加入车辆
@property (nonatomic, assign) NSInteger transactionMoney;   // 交易金额
@property (nonatomic, assign) NSInteger successReserve;     // 成功预订

@end
