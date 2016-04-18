//
//  ConfirmOrderController.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ConfirmOrderController : BaseViewController

@property (nonatomic, assign) NSInteger driverId;

@property (nonatomic, strong) CarDetail *carDetail;

// 是否拼车
@property (nonatomic, assign) BOOL isCarpool;

@end
