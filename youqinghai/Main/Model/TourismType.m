//
//  TourismType.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TourismType.h"

@implementation TourismType

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id",
             @"typeName":@"typename"};
}

@end
