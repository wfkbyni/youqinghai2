//
//  CarViewModel.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "CarViewModel.h"
#import "RequestBaseAPI+Car.h"

@implementation CarViewModel

-(RACSignal *)getCarList{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getCarListWithCartypeId:self.cartypeId
                                                                   wihtEavnum:self.eavnum
                                                               withPriceState:self.priceState
                                                                   withTourId:self.tourId
                                                               withTravelTime:self.travelTime
                                                                withPageIndex:1
                                                                 withPageSize:10] map:^id(ResponseBaseData *data) {
        
        self.cars = [Car mj_objectArrayWithKeyValuesArray:data.result_data];
        return self.cars;
    }];
    
    return signal;
}

-(RACSignal *)getCarTypeList{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getCarTypeList] map:^id(ResponseBaseData *data) {
        
        self.carTypes = [CarType mj_objectArrayWithKeyValuesArray:data.result_data];
        
        return self.carTypes;
    }];
    
    return signal;
}

-(RACSignal *)getDriverCarDetails{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getDriverCarDetailsWithDriverId:self.driverId withUserId:[[ZUserModel shareUserModel].userId integerValue]] map:^id(ResponseBaseData *data) {
        
        self.carDetail = [CarDetail mj_objectWithKeyValues:data.result_data];
        
        self.carDetail.driverInfo = self.carDetail.driverInfo.length == 0 ? @"暂无司机介绍" : self.carDetail.driverInfo;
        
        return data.result_data;
    }];
    
    return signal;
}

-(RACSignal *)getStatisticsPlatformData{
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getStatisticsPlatformData] map:^id(ResponseBaseData *value) {
        
        return value;
    }];
    return signal;
}

@end
