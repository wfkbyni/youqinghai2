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
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] calcCharteredPriceWithTraveId:self.traveId withCarTypeId:self.driverId withIsInsurance:0] map:^id(id value) {
        
        self.calCarPrice = [CalCarPrice mj_objectWithKeyValues:value];
        
        return self.calCarPrice;
    }];
    
    return signal;
}

-(RACSignal *)addOrder{
    
    NSLog(@"%@",[self.order mj_JSONString]);
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] addOrderWithOrder:self.order] map:^id(id value) {
        
        return value;
    }];
    
    return signal;
}


-(RACSignal *)getUserOrderList{
    
    NSString *userID = [ZUserModel shareUserModel].userId;
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getUserOrderList:[userID integerValue] wihtState:-1  withPageIndex:1 withPageSize:10] map:^id(id value) {
        
        self.orderList = [OrderListModel mj_objectArrayWithKeyValuesArray:value];
        return self.orderList;
    }];
    
    return signal;
}
-(RACSignal *)getUserOrderDetail:(NSString*)orderId
{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getUserOrderDetailOrderId:orderId] map:^id(id value) {
        
         self.orderList = @[[OrderListModel mj_objectWithKeyValues:value]];
        return self.orderList;
    }];
    
    return signal;
}
@end
