//
//  CarDetail.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/31.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "CarDetail.h"

@implementation CarDetail

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"imgList":@"Img",@"evalist":@"Eav"};
}

@end

@implementation Eav

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

@end

@implementation Img

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

@end
