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
                                                                 withPageSize:10] map:^id(id value) {
        
        self.cars = [Car mj_objectArrayWithKeyValuesArray:value];
        return self.cars;
    }];
    
    return signal;
}

-(RACSignal *)getCarTypeList{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getCarTypeList] map:^id(id value) {
        
        self.carTypes = [CarType mj_objectArrayWithKeyValuesArray:value];
        
        return self.carTypes;
    }];
    
    return signal;
}

-(RACSignal *)getDriverCarDetails{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getDriverCarDetailsWithDriverId:self.driverId withUserId:myUserId] map:^id(id value) {
        
        self.carDetail = [CarDetail mj_objectWithKeyValues:value];
        
        return value;
    }];
    
    return signal;
}

@end
