//
//  RelationView.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ValueType) {
    ValueTypeWithInsuranceCount,        // 保险人数
};

@interface RelationView : UIView

@property (nonatomic, strong) Order *order;

@property (nonatomic, assign) BOOL isCarpool;

// 包车数据
@property (nonatomic, strong) CalCarPrice *calCarPrice;
// 拼车数据
@property (nonatomic, strong) CalcPrice *calcPrice;

@property (nonatomic, strong) CarType *carType;

@property (nonatomic, assign) NSInteger insuranceCount;       // 保险人数

@property (nonatomic, assign) NSInteger seatsnum;             // 座位数
@property (nonatomic, assign) NSInteger travelNum;             // 出游人数
@property (nonatomic, assign) NSInteger days;                // 出游天数

@property (nonatomic, assign) NSNumber *totalMoeny;           // 总金额

@property (nonatomic, strong) NSArray *insuranceArray;        // 被保人数据

@property (nonatomic, strong) UINavigationController *navigationController;

// 用于返回一些值
@property (nonatomic, copy) void(^returnSomingValue)(ValueType type, id obj);

@end
