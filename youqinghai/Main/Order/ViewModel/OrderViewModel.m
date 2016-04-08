//
//  OrderViewModel.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "OrderViewModel.h"
#import "RequestBaseAPI+Order.h"

@implementation OrderViewModel

-(instancetype)init{
    if (self = [super init]) {
        _order = [[Order alloc] init];
    }
    return self;
}

-(RACSignal *)calcCharteredPrice{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] calcCharteredPriceWithTraveId:self.traveId withCarTypeId:self.carTypeId withIsInsurance:0] map:^id(id value) {
        
        
        
        return value;
    }];
    
    return signal;
}

-(RACSignal *)addOrder{
    return nil;
}

@end
