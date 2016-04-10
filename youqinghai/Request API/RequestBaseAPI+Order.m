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
NSString const *calcPrice= @"app/payOrder/calcPrice";

@implementation RequestBaseAPI (Order)

-(RACSignal *)calcCharteredPriceWithTraveId:(NSInteger)traveId
                              withCarTypeId:(NSInteger)driverId
                            withIsInsurance:(NSInteger)isInsurance{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&traveId=%ld&driverId=%ld",calcCharteredPrice,traveId,driverId];//[NSString stringWithFormat:@"server=%@&traveId=%ld&carTypeId=%ld&isInsurance=%ld",calcCharteredPrice,traveId,carTypeId,isInsurance];
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)calcPriceWithTraveId:(NSInteger)traveId{
    NSString *params = [NSString stringWithFormat:@"server=%@&traveId=%ld",calcPrice,traveId];
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)addOrderWithOrder:(Order *)order{
    
    NSString *params = [order mj_JSONString];
    params = [params stringByReplacingOccurrencesOfString:@"{" withString:@""];
    params = [params stringByReplacingOccurrencesOfString:@"}" withString:@""];
    params = [params stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    params = [params stringByReplacingOccurrencesOfString:@":" withString:@"="];
    params = [params stringByReplacingOccurrencesOfString:@"," withString:@"&"];
    params = [NSString stringWithFormat:@"server=%@&%@",addOrder,params];
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

@end
