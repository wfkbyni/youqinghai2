//
//  HomePageData.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/24.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ResponseBaseData.h"

@interface HomePageData : ResponseBaseData

@property (nonatomic, strong) NSArray *recommend;
@property (nonatomic, strong) NSArray *tourismType;
@property (nonatomic, strong) NSArray *banner;

@end
