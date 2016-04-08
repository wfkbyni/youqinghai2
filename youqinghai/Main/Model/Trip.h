//
//  Trip.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/26.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ResponseBaseData.h"

@interface Trip : ResponseBaseData
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger sort;       //排序
@property (nonatomic, strong) NSString *tripname;   //景点名称
@property (nonatomic, strong) NSString *tripimgurl; //景点图片路径
@end
