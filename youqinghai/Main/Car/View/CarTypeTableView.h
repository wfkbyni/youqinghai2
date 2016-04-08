//
//  CarTypeTableView.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/31.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarTypeTableView : UIView

@property (nonatomic, strong) NSArray *carTypes;

@property (nonatomic, assign) int isAlpha;

@property (nonatomic, copy) void (^SelectCarType)(CarType *carType);

@end
