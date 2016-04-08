//
//  Recommend.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief 推荐线路
 */
@interface Recommend : NSObject

@property (nonatomic, strong) NSString *imgUrl;     // 图片路径
@property (nonatomic, assign) NSInteger Id;         // id
@property (nonatomic, strong) NSString *title;      // 标题
@property (nonatomic, assign) NSInteger sort;       // 排序
@property (nonatomic, strong) NSString *introduce;  // 简介
@property (nonatomic, strong) NSString *partake;    // 用户参与数

@end
