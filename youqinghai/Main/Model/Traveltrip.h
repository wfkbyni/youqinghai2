//
//  Traveltrip.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/26.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ResponseBaseData.h"

@interface Traveltrip : ResponseBaseData
@property (nonatomic, assign) NSInteger day;            // ---第几天
@property (nonatomic, strong) NSArray *traveltriplist;
@property (nonatomic, strong) NSArray *viewlist;
@property (nonatomic, assign) NSInteger collectionNum;  // 收藏数,
@property (nonatomic, assign) NSInteger sort;           // 排序,
@property (nonatomic, assign) NSString *detailesUrl;    // 线路详情地址
@property (nonatomic, assign) NSInteger isCollection;   //  "是否收藏", 0未收藏   1已收藏
@property (nonatomic, strong) NSArray *banner;
@end
