//
//  TourisEvaluate.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TourisEvaluate.h"

@implementation TourisEvaluate

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"listImage":@"EvaluateImg"};
}

@end
