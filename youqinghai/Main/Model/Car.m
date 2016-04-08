//
//  Car.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "Car.h"

@implementation Car

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

@end

@implementation CarType

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

@end
