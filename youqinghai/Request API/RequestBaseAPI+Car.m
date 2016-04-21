//
//  RequestBaseAPI+Car.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI+Car.h"

NSString const *carList = @"app/driverCarInfo/getCarList";
NSString const *carTypeList = @"app/driverCarInfo/getCarTypeList";
NSString const *getDriverCarDetails = @"app/driverCarInfo/getDriverCarDetails";
NSString const *statisticsPlatformData = @"app/driverCarInfo/statisticsPlatformData";

@implementation RequestBaseAPI (Car)

-(RACSignal *)getCarListWithCartypeId:(NSInteger)cartypeId
                           wihtEavnum:(NSInteger)eavnum
                       withPriceState:(NSInteger)priceState
                           withTourId:(NSInteger)tourId
                       withTravelTime:(long)travelTime
                        withPageIndex:(NSInteger)pageIndex
                         withPageSize:(NSInteger)pageSize{
    
    NSString *params;
    if (cartypeId == 0) {
        params = [NSString stringWithFormat:@"server=%@&eavnum=%ld&priceState=%ld&tourId=%ld&travelTime=%ld&pageIndex=%ld&pageSize=%ld",carList,eavnum,priceState,tourId,travelTime,pageIndex,pageSize];
    }else{
        params = [NSString stringWithFormat:@"server=%@&eavnum=%ld&priceState=%ld&tourId=%ld&travelTime=%ld&pageIndex=%ld&pageSize=%ld&cartypeId=%ld",carList,eavnum,priceState,tourId,travelTime,pageIndex,pageSize,cartypeId];
    }
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)getCarTypeList{
    
    NSString *params = [NSString stringWithFormat:@"server=%@",carTypeList];
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)getDriverCarDetailsWithDriverId:(NSInteger)driverId withUserId:(NSInteger)userId{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&driverId=%ld&userId=%ld",getDriverCarDetails,driverId,userId];
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)getStatisticsPlatformData{
    NSString *params = [NSString stringWithFormat:@"server=%@",statisticsPlatformData];
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}


-(RACSignal*)getAllEvaDateWithdriverId:(NSString*)driverId
                             withgrade:(NSString*)grade
                         withpageIndex:(NSString*)pageIndex
                          withpageSize:(NSString*)pageSize
{
    
    NSString *param = [NSString stringWithFormat:@"server=%@&driverId=%@&pageIndex=%@&pageSize=%@",@"app/driverCarInfo/getAllEavList", driverId,pageIndex,pageSize];
    if (grade) {
       param= [param stringByAppendingString:[NSString stringWithFormat:@"&grade=%@",grade]];
    }
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
    
}
@end
