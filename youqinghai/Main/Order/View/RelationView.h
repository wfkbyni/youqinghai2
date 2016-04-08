//
//  RelationView.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RelationView : UIView

@property (nonatomic, strong) Order *order;
@property (nonatomic, strong) CalCarPrice *calCarPrice;

@property (nonatomic, assign) NSInteger insuranceCount;       // 保险人数

@property (nonatomic, strong) UINavigationController *navigationController;

@end
