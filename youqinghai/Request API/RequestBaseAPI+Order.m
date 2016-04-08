//
//  RequestBaseAPI+Order.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI+Order.h"

NSString const *calcCharteredPrice = @"app/payOrder/calcCharteredPrice";
NSString const *addOrder = @"app/payOrder/addOrder";

@implementation RequestBaseAPI (Order)

-(RACSignal *)calcCharteredPriceWithTraveId:(NSInteger)traveId
                              withCarTypeId:(NSInteger)carTypeId
                            withIsInsurance:(NSInteger)isInsurance{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&traveId=%ld&carTypeId=%ld",calcCharteredPrice,traveId,carTypeId];//[NSString stringWithFormat:@"server=%@&traveId=%ld&carTypeId=%ld&isInsurance=%ld",calcCharteredPrice,traveId,carTypeId,isInsurance];
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)addOrderWithOrder:(Order *)order{
    
    NSString *params = @"";
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

@end
