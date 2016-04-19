//
//  InsuranceViewController.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/19.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsuranceViewController : UIViewController

// 最大保险人数
@property (nonatomic, assign) NSInteger maxCount;

@property (nonatomic, copy) void(^InsuranceDataCall)(NSArray *insuranceData);
@end
